import 'package:app_version_update/app_version_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/color.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pickeat/function/user_activity.dart';
import 'package:pickeat/login/choose_location.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:pickeat/home/home_screen.dart';
import 'dart:io';

import '../enum/location.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  String location = '';

  @override
  void initState() {
    _verifyVersion();
    super.initState();
  }

  void _verifyVersion() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: '6590604851',
      playStoreId: 'com.anyway.pickeat',
    ).then((result) async {
      if (result.canUpdate!) {
        print('!!!!!!!!!!!!!!');
        // await AppVersionUpdate.showBottomSheetUpdate(context: context, appVersionResult: appVersionResult)
        // await AppVersionUpdate.showPageUpdate(context: context, appVersionResult: appVersionResult)
        // or use your own widget with information received from AppVersionResult

        //##############################################################################################
        await AppVersionUpdate.showAlertUpdate(
          appVersionResult: result,
          context: context,
          mandatory: true,
          backgroundColor: Colors.grey[200],
          title: 'NEW 버전 업데이트!',
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
          content: '업데이트 후 앱을 사용해 주세요.',
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          updateButtonText: '업데이트',
          cancelButtonText: 'LATER',
          updateButtonStyle: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(245, 47, 70, 1.0))),
        );

        //## AppVersionUpdate.showBottomSheetUpdate ##
        // await AppVersionUpdate.showBottomSheetUpdate(
        //   context: context,
        //   mandatory: true,
        //   appVersionResult: result,
        // );

        //## AppVersionUpdate.showPageUpdate ##

        // await AppVersionUpdate.showPageUpdate(
        //   context: context,
        //   appVersionResult: result,
        // );
      }
    });
    // TODO: implement initState
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
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


      if (googleUser == null) {
        return null;
      } else {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }

    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null; // or handle the error appropriately
    }
  }


  Future<UserCredential?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<UserCredential?> signInAnonymous() async {
    try {
      final anonymousCredential =
          await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      // 유저가 로그인이 되어있는 유저인지 아닌지 판단
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            //user activity 받아서 화면 보여줌 (강남, 신촌, 관악 중 유저가 선택한 것을 불러옴)
            return FutureBuilder(
              future: getUserActivity(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('User Activity Error');
                } else {

                  if (snapshot.data == null) {
                    context.go('/login');
                  }

                  return HomeScreen(location: snapshot.data);
                }
              },
            );
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
                                    // 아이디 입력
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
                                        fillColor:
                                            Color.fromRGBO(155, 155, 155, 0.2),
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
                                    // 비밀번호 입력
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
                                        fillColor:
                                            Color.fromRGBO(155, 155, 155, 0.2),
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
                                    // 아이디비번 로그인과 간편 로그인 구분선
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
                                    ),
                                    // 간편 로그인
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //구글 로그인
                                        GestureDetector(
                                          onTap: () async {
                                            final userCredit =
                                                await signInWithGoogle();

                                            if (userCredit == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text("구글 로그인 실패"),
                                              ));
                                              return;
                                            }

                                            if (context.mounted) {
                                              context.go("/choose_location");
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
                                        //애플 로그인
                                        if (Platform.isIOS) SizedBox(width: 30),
                                        if (Platform.isIOS)
                                          GestureDetector(
                                            onTap: () async {
                                              final result =
                                                  await signInWithApple();
                                              if (result != null) {
                                                if (context.mounted) {
                                                  context.go("/choose_location");
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("애플 로그인 실패"),
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
                        Row(
                          children: [
                            // 로그인 건너뛰기
                            Flexible(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () async {
                                  final userCredit = await signInAnonymous();

                                  if (context.mounted) {
                                    context.go("/choose_location");
                                  }
                                },
                                height: 48,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: picketColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "건너뛰기",
                                      style: TextStyle(
                                        color: picketColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),

                            // 로그인하기 버튼
                            Flexible(
                              flex: 2,
                              child: MaterialButton(
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
                                      context.go("/choose_location");
                                    }
                                  }
                                },
                                height: 48,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                            //회원가입 버튼
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
      ),
    );
  }
}
