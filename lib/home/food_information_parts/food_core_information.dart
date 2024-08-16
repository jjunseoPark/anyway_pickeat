import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickeat/const/detect_zero.dart';
import 'package:pickeat/model/shops.dart';

class FoodCoreInformation extends StatefulWidget {

  Shop shop;

  FoodCoreInformation({required this.shop, super.key});

  @override
  State<FoodCoreInformation> createState() => _FoodCoreInformationState();
}

class _FoodCoreInformationState extends State<FoodCoreInformation> {

  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text(
//menu_name*************************************
                    widget.shop.menu_name!,
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
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
//store_name*************************************
                        widget.shop.store_name!,
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
              Text(
//menu_price*************************************
                "${f.format(widget.shop.menu_price!)}원",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //별점정보
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(125, 125, 125, 0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: Text(
//store_rating_kakao*************************************
                                detectZero(widget.shop.store_rating_kakao),
                                style: TextStyle(
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
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 0, 0),
                              child: Text(
//store_count_kakao*************************************
                                "(${detectZero(widget.shop.store_count_kakao!)})",
                                style: TextStyle(
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
                    color: Color.fromRGBO(125, 125, 125, 0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: Text(
//store_rating_naver*************************************
                                detectZero(widget.shop.store_rating_naver!),
                                style: TextStyle(
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
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 0, 0),
                              child: Text(
//store_count_naver*************************************
                                "(${detectZero(widget.shop.store_count_naver!)})",
                                style: TextStyle(
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
      height: 90,
    );
  }
}
