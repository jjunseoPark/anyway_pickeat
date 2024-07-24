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
      child: Padding(padding : EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
        child: Column(
          children: [
            //위치표시
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromRGBO(125, 125, 125, 0.8),
              ),
              height: 40,
              width: 260,
              child: Center(
                child: Text(
                  "서울시 마포구: 2.3km",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //빈공간
            Expanded(
              child: Container(),
            ),

            // 설명창
            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //가게정보
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("연어 스테이크 & 샐러드",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.store,
                                size: 20,
                                color: Colors.white
                              ),
                              SizedBox(width: 5,),
                              Text("프레쉬 앤 그릴 마포점",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text("14,900원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  //별점정보
                  Padding( padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(125, 125, 125, 0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/image/KakaoMap_logo.png",
                                      width: 15,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:5),
                                      child: Text("4.6",
                                        style:
                                          TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Color(0xffdca52d),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,0,0,0
                                      ),
                                      child: Text("(17)",
                                      style:
                                        TextStyle(
                                         color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(125, 125, 125, 0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/image/NaverMap_logo.png",
                                      width: 15,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:5),
                                      child: Text("4.6",
                                        style:
                                        TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Color(0xffdca52d),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,0,0,0
                                      ),
                                      child: Text("(17)",
                                        style:
                                        TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ),
                      ],
                    ),
                  )
                ],
              ),
              height: 100,
            ),

            // 바로 주문하기 버튼
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: picketColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
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
      ),
    );
  }
}
