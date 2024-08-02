import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/color.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:pickeat/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(credential);
      Analytics_config().viewLogin();
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print(e.toString());
      } else if (e.code == "wrong-password") {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithApple() async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oAuthProvider = OAuthProvider("apple.com");

    final credential = oAuthProvider.credential(
      idToken: result.identityToken,
      accessToken: result.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 42,
                                  ),
                                ),
                                Text(
                                  "쇼츠와 함께하는 오늘의 메뉴",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          labelText: "이메일",
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              155, 155, 155, 0.2),
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
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          labelText: "비밀번호",
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              155, 155, 155, 0.2),
                                        ),
                                        obscureText: true,
                                        keyboardType:
                                        TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "비밀번호를 입력하세요.";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "or",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ), // 구분선과 로그인 버튼 사이의 공간 추가
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final userCredit = await signInWithGoogle();

                                              if (userCredit == null) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("구글 로그인 실패"),
                                                ));
                                                return;
                                              }

                                              if (context.mounted) {
                                                context.go("/");
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  width: 1,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: AssetImage(
                                                    "assets/image/google_logo.png"),
                                                radius: 24,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          GestureDetector(
                                            onTap: () async {
                                              final result =
                                              await signInWithApple();
                                              if (result != null) {
                                                if (context.mounted) {
                                                  context.go("/");
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "애플 로그인 실패"),
                                                ));
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/image/apple_logo.png"),
                                              radius: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                final result = await signIn(
                                    emailTextController.text.trim(),
                                    pwdTextController.text.trim());

                                if (result == null) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("로그인 실패"),
                                    ));
                                  }
                                  return;
                                }

                                if (context.mounted) {
                                  Analytics_config().login();
                                  context.go("/");
                                }
                              }
                            },
                            height: 48,
                            minWidth: double.infinity,
                            color: picketColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "계정이 없나요?",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push("/sign_up"),
                                child: Text(
                                  "회원가입",
                                  style: TextStyle(
                                    color: picketColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
