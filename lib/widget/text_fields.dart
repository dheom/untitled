import 'package:flutter/material.dart';

class TextFormFieldsCustom extends StatefulWidget {
  String? defaultText; //기본적으로 쓰이는 텍스트값
  String? hintText;
  bool isPasswordField = false; //비밀번호
  bool? isEnabled; //텍스트 필드 활성화여부
  int? maxLines; //텍스트 필드 줄수
  bool isReadOnly; //텍스트 필드 읽기전용여부
  TextInputType? keyboardType; //키보드 타입
  TextInputAction textInputAction; //키보드 액션
  FormFieldValidator validator; //유효성검사
  TextEditingController? controller; //컨트롤러
  Function(String value)? onFieldSubmitted; //엔터 이벤트 변경;
  Function()? onTap;

  TextFormFieldsCustom({
    this.defaultText,
    this.hintText,
    required this.isPasswordField,
    this.isEnabled,
    this.maxLines,
    required this.isReadOnly,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    required this.controller,
    this.onFieldSubmitted,
    this.onTap,
    super.key,
  });

  @override
  State<TextFormFieldsCustom> createState() => _TextFormFieldsState();
}

class _TextFormFieldsState extends State<TextFormFieldsCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // state에서 가져온 이 클래스에서 전역변수로 선언된 다른 클래스를 가져오고 싶으면 widget을 쓴다
      initialValue: widget.defaultText,
      obscureText: widget.isPasswordField,
      enabled: widget.isEnabled,
      maxLines: widget.maxLines,
      readOnly: widget.isReadOnly ? true : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: (value) => widget.validator(value),
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.isReadOnly ? widget.onTap : null,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        //활성화 되었을때
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(4),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blueAccent),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
