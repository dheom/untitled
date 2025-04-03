import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/common/snackbar_util.dart';
import 'package:untitled/widget/buttons.dart';
import 'package:untitled/widget/text_fields.dart';
import '../widget/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<
      FormState>(); // 위젯에는 전부 키가 존재, 위젯과의 상하관계 설정을 위해 쓴다고 생각하면됌
  final supabase = Supabase.instance.client;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 160),
                const Center(
                  child: Text(
                    'Food Pick',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 53),
                SectionText(text: '이메일', textColor: Color(0x979797)),
                const SizedBox(height: 8),
                TextFormFieldsCustom(
                  isPasswordField: false,
                  isReadOnly: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => inputEmailValidator(value),
                  controller: _emailController,
                ),

                SizedBox(height: 28),

                SectionText(text: '비밀번호', textColor: Color(0x979797)),
                const SizedBox(height: 8),
                TextFormFieldsCustom(
                  maxLines: 1,
                  isPasswordField: true,
                  isReadOnly: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) => inputEmailValidator(value),
                  controller: _passwordController,
                ),

                Container(
                  width: double.infinity,
                  height: 52,
                  child: SingleChildScrollView(
                    // UI가 잘릴 위험 방지
                    child: ElevatedButtonCustom(
                      text: '로그인',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPresesd: () async {
                        String emailValue = _emailController.text;
                        String passwordValue = _passwordController.text;
                        if (!formKey.currentState!.validate()) {
                          //모든 state의 유효성이 가능하지않는다면
                          return;
                        }

                        bool isLoginSuccess = await loginWithEmail(
                            emailValue, passwordValue);
                        if (!context.mounted) return;
                        //context 가 유효한지 확인하고 실행해 - 비동기 실행시
                        if (!isLoginSuccess) {
                          showSnackBar(context, '로그인 실패');
                          return;
                        }

                        Navigator.popAndPushNamed(context, '/main');
//화면을 제거한다 pop , 화면 생성 Push
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButtonCustom(
                    text: '가입하기',
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    onPresesd: () {
                      Navigator.pushNamed(context, '/register');
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

  Future<bool> loginWithEmail(String emailValue, String passwordValue) async {
    //이메일 로그인(수파베이스)
    bool isLoginSuccess = false;
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: emailValue, password: passwordValue,);
    if (response.user != null) {
      isLoginSuccess = true;
    } else {
      isLoginSuccess = false;
    }
    return isLoginSuccess;
  }
}
