import 'package:flutter/material.dart';

//홈화면
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NaverMapController _mapController;
  Completer<NaverMapController> mapControllerCompleter =
      Completer(); //컴플리터는 위치가 변경됬다고 알려주는것

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions( //const 는 불변이니까
          indoorEnable: true, //실내맵 활용
          locationButtonEnable: true, //내위치로 이동 버튼
          consumeSymbolTapEvents: false, //심볼탭 이벤트 소비여부
        ),
        onMapReady: (controller) async {
          _mapController:
          (controller);
          //이동하고싶은 카메라 위치 추출,
          NCameraPosition target = await getMyLocation();
          //이동하고 싶은 카메라 위치 추출(내위치)
          NCameraPosition myPostion = await getMyLocation();

          //추출한 위치 카메라 업데이트
          _mapController.updateCameraPosition(
            NCamerUpdate.fromCameraPosition(myPostion),
          );
          mapControllerCompleter.complete(_mapController); //지도 컨트롤러 완료 신호 전송
        },
      ),
    );
  }

  Future<NCameraPosition> getMyLocation() async {
    //위치권한을 체크해서 권한 허용이 되어있다면 내 현위치 정보 제공
    bool serviceEnabled;
    LocationPermission permission;
    //위치 서비스 이용가능 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스를 활성화 해주세요');
    }

    //위치권한 현재 상태 체크
    permission = await Geolocator.checkPermission();
    //만약 위치 권한 허용 팝업 사용자가 거부했다면
    if (permission == LocationPermission.denied) {
      //위치권한 팝업 표시
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한을 허용해주세요');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('앱의 위치 권한을 설정에서 허용해주세요');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return NCameraPosition(
      target: NLatLng(position.latitude, position.longitude),
      zoom: 12,
    );
  }
}
