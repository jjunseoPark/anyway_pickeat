import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/const/launch_url.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "계정",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "내 프로필",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: user?.email ?? '회원가입 유저가 아닙니다.',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      labelText: '이메일',
                      filled: true,
                      fillColor: Color.fromRGBO(240, 240, 240, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Column(
              children: [
                if (user != null && !user.isAnonymous)
                  MaterialButton(
                    onPressed: () async {
                      if (context.mounted) {
                        context.pop();
                        context.go('/login');
                      }
                      await FirebaseAuth.instance.signOut();
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
                          "Logout",
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
                if (user != null && user.isAnonymous)
                  MaterialButton(
                    onPressed: () async {
                      if (context.mounted) {
                        context.pop();
                        context.go('/login');
                      }

                      await FirebaseAuth.instance.signOut();
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
                          "회원가입",
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
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
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
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            await user.delete();
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
                            context.go('/login');
                          } else {
                            Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('계정 삭제 중 오류가 발생했습니다.')),
                            );
                          }
                        } catch (e) {
                          Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('오류: $e')),
                          );
                        }
                      },
                      child: Text(
                        "계정 삭제하기",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchURL("http://pf.kakao.com/_IHxayG/chat");
                      },
                      child: Text(
                        "문의하기",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
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
}

Future<void> deleteID() async {}
