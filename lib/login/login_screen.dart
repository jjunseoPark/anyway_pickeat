import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/const/color.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(credential);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: picketColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  context.go("/");
                },
                child: Image.asset(
                  "assets/image/main-logo.png",
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ),
              Text(
                "Pickeat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                ),
              ),
              SizedBox(
                height: 64,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "이메일",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이메일 주소를 입력하세요.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: pwdTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "패스워드",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력하세요.";
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 64,
              ),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final result = await signIn(emailTextController.text.trim(),
                        pwdTextController.text.trim());

                    if (result == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("로그인 실패"),
                        ));
                      }
                      return;
                    }

                    if (context.mounted) {
                      context.go("/");
                    }
                  }
                },
                height: 48,
                minWidth: double.infinity,
                color: Colors.white,
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.push("/sign_up"),
                child: Text(
                  "계정이 없나요? 회원가입",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              MaterialButton(
                color: Colors.white,
                onPressed: () async {
                  final userCredit = await signInWithGoogle();

                  if (userCredit == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("구글 로그인 실패"),
                    ));
                    return;
                  }
                  if (context.mounted) {
                    context.go("/");
                  }  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/google_logo.png",
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("구글로 로그인하기"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
