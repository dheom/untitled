import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/widget/buttons.dart';
import 'package:untitled/widget/text_fields.dart';
import 'package:untitled/widget/texts.dart';

import '../common/snackbar_util.dart';
import '../widget/appbars.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //이미지 기입 로직 추가
  File? profileImg;
  final formKey = GlobalKey<FormState>(); // 위젯에는 전부 키가 존재, 위젯과의 상하관계 설정을 위해 쓴다고 생각하면됌
  final supabase = Supabase.instance.client;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordReController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Food PICK 가입하기', isLeading: true),
      body: SingleChildScrollView(
        // 스크롤 기능 삽입 _마지막 작업
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              //컬럼에서 CrossAxis는 수평
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //프로필사진
                GestureDetector(
                  child: _buildProfile(),
                  onTap: () {
                    //제스쳐 디텍터는 바텀시트올리는 기능같은 것, 프로필 이미지 변경 및 삭제 팝업 띄우기
                    showBottomSheetAboutProfile();
                  },
                ),
                //섹션 및 입력 필드들
                SectionText(text: '닉네임', textColor: Color(0x979797)),
                //input 에서 input action next면 완료버튼 대신 다음 필드 채우러감,입력가능한 조건 줄수있음
                TextFormFieldsCustom(
                  hintText: '닉네임을 입력해주세요',
                  isPasswordField: false,
                  isReadOnly: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputNameValidator(value),
                  controller: _nameController,
                ),

                const SizedBox(height: 16),
                SectionText(text: '이메일', textColor: Color(0x979797)),
                TextFormFieldsCustom(
                  hintText: '이메일을 입력해주세요',
                  isPasswordField: false,
                  isReadOnly: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputEmailValidator(value),
                  controller: _emailController,
                ),

                const SizedBox(height: 16),
                //obsecure Text는 비밀번호 입력 시 * 처리 됌
                SectionText(text: '비밀번호', textColor: Color(0x979797)),
                TextFormFieldsCustom(
                  hintText: '비밀번호를 입력해주세요',
                  isPasswordField: true,
                  maxLines: 1,
                  isReadOnly: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputPasswordValidator(value),
                  controller: _passwordController,
                ),

                const SizedBox(height: 16),
                SectionText(text: '비밀번호 확인', textColor: Color(0x979797)),
                TextFormFieldsCustom(
                  hintText: '비밀번호 확인',
                  maxLines: 1,
                  isPasswordField: true,
                  isReadOnly: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputPasswordReValidator(value),
                  controller: _passwordReController,
                ),

                const SizedBox(height: 16),
                SectionText(text: '자기소개', textColor: Color(0x979797)),
                TextFormFieldsCustom(
                  hintText: '자기소개를 입력해주세요',
                  isPasswordField: false,
                  isReadOnly: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputintroduceValidator(value),
                  controller: _introduceController,
                  maxLines: 5,
                ),
                //가입완료 버튼
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButtonCustom(
                    text: '가입완료',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPresesd: () async {
                      //가입완료시 호출
                      String emailValue = _emailController.text;
                      String passwordValue = _passwordController.text;
                      //유효성검사 체크
                      if (!formKey.currentState!.validate()) {
                        //모든 state의 유효성이 가능하지않는다면
                        return;
                      }

                      //유효성검사 통과시 하단 로직 진행
                      bool isRegisterSuccess = await registerAccount(
                        emailValue,
                        passwordValue,
                      );
                      if (!context.mounted) return;//context 가 유효한지 확인하고 실행해 - 비동기 실행시
                      if (!isRegisterSuccess) {

                        showSnackBar(context, '회원가입 실패');
                        return;
                      }
                      showSnackBar(context, '회원가입 성공');
                      Navigator.pop(context); // 나가기

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    if (profileImg == null) {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 48,
          child: Icon(Icons.add_a_photo, color: Colors.white, size: 48),
        ),
      );
    } else {
      return Center(
        child: CircleAvatar(
          backgroundImage: FileImage(profileImg!),
          radius: 48,
        ),
      );
      //메소드 만들기
    }
  }

  void showBottomSheetAboutProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //사진촬영버튼
              TextButton(
                onPressed: () {
                  //사진촬영
                  Navigator.pop(context);
                  getCameraImage();
                },
                child: Text(
                  '사진촬영',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              //앨범에서 사진선택
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getGalleryImage();
                },
                child: Text(
                  '앨범 사진 선택',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              //프로필사진삭제
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deleteProfileImg();
                },
                child: Text(
                  '프로필사진삭제',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getCameraImage() async {
    //카메라로 사진 촬영하여 이미지 가져오는 함수
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        profileImg = File(image.path);
      });
    }
  }

  Future<void> getGalleryImage() async {
    //갤러리에서 사진 선택
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (image != null) {
      setState(() {
        profileImg = File(image.path);
      });
    }
  }

  void deleteProfileImg() {
    setState(() {
      profileImg == null;
    });
  }

  inputNameValidator(value) {
    //닉네임 필드 검증 함수
    if (value.isEmpty) {
      return '닉네임을 입력해주세요';
    }
    return null;
  }

  inputEmailValidator(value) {
    if (value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    return null;
  }

  inputPasswordValidator(value) {
    if (value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    return null;
  }

  inputPasswordReValidator(value) {
    if (value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    return null;
  }

  inputintroduceValidator(value) {
    if (value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    return null;
  }

  Future<bool> registerAccount(String emailValue, String passwordValue) async {
    //이메일 회원가입 시도'
    bool isRegisterSuccess = false;

    final AuthResponse authResponse = await supabase.auth.signUp(
      email: emailValue,
      password: passwordValue,
    );
    if (authResponse.user != null) {
      isRegisterSuccess = true;
      //1. 프로필 사진 등록했다면 업로드
      String? imageUrl;
      DateTime nowTime = DateTime.now();
      if (profileImg != null) {
        final imgFile = profileImg;
        await supabase.storage
            .from('food_pick')
            .upload(
              'profiles/${authResponse.user!.id}_${nowTime}.jpg',
              imgFile!,
              fileOptions: FileOptions(cacheControl: '3600', upsert: true),
            ); //upsert는 겹치면 덮어 써라 라는 뜻

        //업로드된 파일의 이미지 url 주소를 취득해야함
        imageUrl = supabase.storage
            .from('food_pick')
            .getPublicUrl('profiles/${authResponse.user!.id}_${nowTime}.jpg');
      }

      //2. supaase db에 insert
      await supabase
          .from('user')
          .insert(
            UserModel(
              profileUrl: imageUrl,
              name: _nameController.text,
              email: emailValue,
              introduce: _introduceController.text,
              uid: authResponse.user!.id,
            ).toMap(),
          );
    } else {
      isRegisterSuccess = false;
    }
    return isRegisterSuccess;
  }

}

//state를 이용해서 전체를 리빌드하지않고 특정 변수만 변경할수있도록 하자
