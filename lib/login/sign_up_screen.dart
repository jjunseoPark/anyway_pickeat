import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

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

  Future<bool> signUp(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailAddress, password: password);
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
                              labelText: "Email",
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
                              labelText: "Password",
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
                          TextFormField(
                            controller: nicknameTextController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Nickname",
                              filled: true,
                              fillColor: Color.fromRGBO(155, 155, 155, 0.2),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "닉네임을 입력하세요.";
                              }
                              return null;
                            },
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
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final result = await signUp(
                        emailTextController.text.trim(),
                        pwdTextController.text.trim(),
                      );

                      if (result) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("회원가입 성공")),
                          );
                          context.go("/login");
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("회원가입 실패")),
                          );
                        }
                      }
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
                        "Start",
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
        ),
      ),
    );
  }
}