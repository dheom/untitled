import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isLeading; //백버튼 존재 여부
  Function? onTapBackButton; //뒤로가기 액션 버튼
  List<Widget>? actions; //앱바 우측에 버튼들 필요할때 정의

  CommonAppBar({
    super.key,
    required this.title,
    required this.isLeading,
    this.onTapBackButton,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 48,
      automaticallyImplyLeading: isLeading,
      //뒤로가기 버튼자동생성 해줄까?
      titleSpacing: isLeading ? 0 : 16,
      //뒤로가기 있으면 0 없으면 16
      scrolledUnderElevation: 3,
      // 그냥 이뻐짐
      backgroundColor: Colors.white,
      leading: isLeading ? GestureDetector(
        child: Icon(Icons.arrow_back, color: Colors.black,),
        onTap: () {
          onTapBackButton != null ? onTapBackButton!.call() : Navigator.pop(
              context); //뒤로가기 버튼이 null아니고 맞을때 구분
        }
        ,) : null,
      elevation: 1,
      actions: actions,
      //null 허용해둬서
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}