import 'package:flutter/material.dart';
import 'package:pickeat/home/food_information_parts/food_button.dart';
import 'package:pickeat/home/food_information_parts/food_core_information.dart';
import 'package:pickeat/home/food_information_parts/food_location.dart';
import 'package:pickeat/home/food_information_parts/food_sidebar.dart';
import 'package:pickeat/home/food_information_parts/food_topbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/color.dart';
import 'dart:math' as math;

import '../model/shops.dart';

class FoodInformation extends StatefulWidget {

  Shop shop;

  FoodInformation({required this.shop ,super.key});

  @override
  State<FoodInformation> createState() => _FoodInformationState();
}

class _FoodInformationState extends State<FoodInformation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          children: [
            //위치표시
            //FoodLocation(shop: widget.shop),

            //topbar(지역선택, 프로필)
            FoodLocation(shop: widget.shop),

            //빈공간
            Expanded(
              child: Container(),
            ),
            //좋아요,공유,리뷰
            FoodSidebar(shop: widget.shop),
            //빈공간
            SizedBox(
              height: 30,
            ),
            // 설명창
            FoodCoreInformation(shop: widget.shop),
            // 두 개의 버튼
            FoodButton(shop: widget.shop),
          ],
        ),
      ),
    );
  }
}
