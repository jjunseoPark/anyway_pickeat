import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/color.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart'; // 이 줄을 추가하세요.

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  TextEditingController nicknameTextController = TextEditingController();
  bool _agreeToTerms = false; // 체크박스 상태를 저장하는 변수

  Future<bool> signUp(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailAddress, password: password);
      await FirebaseFirestore.instance.collection("users").add({
        "uid": credential.user?.uid ?? "",
        "email": credential.user?.email ?? "",
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("패스워드가 약합니다.");
      } else if (e.code == "email-already-in-use") {
        print("이미 정보가 존재합니다.");
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    super.initState();
    Analytics_config().viewSignup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "오늘의 메뉴를 \n만나러 가볼까요?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailTextController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              labelText: "이메일",
                              filled: true,
                              fillColor: Color.fromRGBO(155, 155, 155, 0.2),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "이메일 주소를 입력하세요.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: pwdTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelText: "비밀번호",
                              filled: true,
                              fillColor: Color.fromRGBO(155, 155, 155, 0.2),
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "비밀번호를 입력하세요.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // TextFormField(
                          //   controller: nicknameTextController,
                          //   decoration: InputDecoration(
                          //     suffixIcon: Icon(
                          //       Icons.person,
                          //       color: Colors.grey,
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     labelText: "닉네임",
                          //     filled: true,
                          //     fillColor: Color.fromRGBO(155, 155, 155, 0.2),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return "닉네임을 입력하세요.";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _agreeToTerms,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _agreeToTerms = newValue!;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '이용약관',
                                      style: TextStyle(
                                        color: picketColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchURL("https://solv-it.notion.site/f21a9dfac56a4688bf6f03c86fffdf60?pvs=4"); // 이용약관 URL로 변경
                                        },
                                    ),
                                    TextSpan(
                                      text: ' 및 ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '개인정보 방침',
                                      style: TextStyle(
                                        color: picketColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchURL("https://solv-it.notion.site/f21a9dfac56a4688bf6f03c86fffdf60?pvs=4"); // 개인정보 처리 방침 URL로 변경
                                        },
                                    ),
                                    TextSpan(
                                      text: '에 동의합니다.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100, // Add some space at the bottom to prevent overflow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _agreeToTerms) {
                          _formKey.currentState!.save();

                          // 로딩 화면 표시
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          try {
                            final result = await signUp(
                              emailTextController.text.trim(),
                              pwdTextController.text.trim(),
                            );

                            if (result) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("회원가입 성공")),
                                );

                                await Analytics_config().signup();

                                Navigator.of(context).pop(); // 로딩 화면 닫기
                                context.go('/choose_location');
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("회원가입 실패")),
                                );
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            Navigator.of(context).pop(); // 로딩 화면 닫기

                            String errorMessage;

                            switch (e.code) {
                              case 'email-already-in-use':
                                errorMessage = '이미 사용 중인 이메일입니다.';
                                break;
                              case 'invalid-email':
                                errorMessage = '유효하지 않은 이메일 형식입니다.';
                                break;
                              case 'weak-password':
                                errorMessage = '비밀번호가 너무 약합니다.';
                                break;
                              case 'operation-not-allowed':
                                errorMessage = '이 작업은 허용되지 않습니다.';
                                break;
                              default:
                                errorMessage = '알 수 없는 오류가 발생했습니다.';
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)),
                              );
                            }
                          } catch (e) {
                            Navigator.of(context).pop(); // 로딩 화면 닫기

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("오류: $e")),
                              );
                            }
                          } finally {
                            if (context.mounted) {
                              Navigator.of(context).pop(); // 로딩 화면 닫기
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("약관에 동의해야 합니다.")),
                          );
                        }
                      },
                      height: 48,
                      minWidth: double.infinity,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "시작하기",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop(); // 로그인 화면으로 이동
                      },
                      child: Text(
                        "이미 계정이 있으신가요?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

