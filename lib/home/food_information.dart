import 'package:flutter/material.dart';

import '../const/color.dart';

class FoodInformation extends StatefulWidget {
  const FoodInformation({super.key});

  @override
  State<FoodInformation> createState() => _FoodInformationState();
}

class _FoodInformationState extends State<FoodInformation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //위치표시
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            height: 50,
            width: 300,
            child: Center(
              child: Text(
                "서울시 마포구: 2.3km",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //빈공간
          Expanded(
            child: Placeholder(),
          ),

          // 설명창
          Container(
            child: Column(
              children: [
                //가게정보
                Row(
                  children: [
                    Image.asset(
                      "assets/google_logo.png",
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        Text("연어 스테이크 & 샐러드", style: TextStyle(fontSize: 20),),
                        Text("프레쉬 앤 그릴 마포점")
                      ],
                    ),
                    Text("14,900원"),
                  ],
                ),
                //별점정보
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/google_logo.png",
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                              Text("4.6"),
                            ],
                          ),
                          SizedBox(width: 30,),
                          Row(
                            children: [
                              Image.asset(
                                "assets/google_logo.png",
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                              Text("4.6"),
                            ],
                          ),
                        ],
                      ),

                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/google_logo.png",
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                              Text("4.6"),
                            ],
                          ),
                          SizedBox(width: 30,),
                          Row(
                            children: [
                              Image.asset(
                                "assets/google_logo.png",
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                              Text("4.6"),
                            ],
                          ),
                        ],
                      ),

                    )
                  ],
                )
              ],
            ),
            height: 100,
          ),

          // 바로 주문하기 버튼
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: picketColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(300, 100),
              ),
              onPressed: () {},
              child: Text(
                "바로 주문하기",
                style: baseTextStyle,
              ),
            ),
            height: 50,
          ),
        ],
      ),
    );
  }
}
