import 'package:flutter/material.dart';

import 'favorite_screen.dart';
import 'home_screen.dart';
import 'my_info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; //화면 선택 위치 0,1,2...
  final _screenType = [
    //home,favorite,myinfo 3개로 분할 할꺼임
    HomeScreen(), //홈화면
    FavoriteScreen(), //찜하기
    MyInfoScreen(), //내정보화면
  ]; //리스트 데이터타입임

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenType.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xff14ff00),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보'),
        ],
      ),
    );
  }
}
