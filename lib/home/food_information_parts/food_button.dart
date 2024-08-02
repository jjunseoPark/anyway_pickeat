import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pickeat/const/url_button.dart';
import 'package:pickeat/model/shops.dart';

import '../../const/color.dart';
import '../../const/launch_url.dart';

class FoodButton extends StatefulWidget {

  Shop shop;

  FoodButton({required this.shop,super.key});

  @override
  State<FoodButton> createState() => _FoodButtonState();
}

class _FoodButtonState extends State<FoodButton> {



  void _showDeliveryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '배달 주문하기',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfff6f6f6),),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //coupang_url*************************************
                      if (widget.shop.coupang_url! != "")  UrlButton(type: "배달", image: "assets/image/coupang_logo.png", name: "쿠팡 이츠", url: widget.shop.coupang_url!, shop: widget.shop),
                      //yogiyo_url*************************************
                      if (widget.shop.yogiyo_url! != "")  UrlButton(type: "배달", image: "assets/image/yogiyo_logo.png", name: "요기요", url: widget.shop.yogiyo_url!, shop: widget.shop),
                      //baemin_url*************************************
                      if (widget.shop.baemin_url! != "") UrlButton(type: "배달",image: "assets/image/baemin_logo.png", name: "배달의 민족", url: widget.shop.baemin_url!, shop: widget.shop),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPickupBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '지도 보러가기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfff6f6f6),),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //naver_url*************************************
                      if (widget.shop.naver_url! != "")  UrlButton(type: "지도", image: "assets/image/Naver_logo.png", name: "네이버지도", url: widget.shop.naver_url!, shop: widget.shop),
                      //kakaoMap_url*************************************
                      if (widget.shop.kakaoMap_url! != "") UrlButton(type: "지도", image: "assets/image/Kakao_logo.png", name: "카카오지도", url: widget.shop.kakaoMap_url!, shop: widget.shop),
                      //AppleMap_url*************************************
                      if (widget.shop.kakaoMap_url! != "" && Platform.isIOS) UrlButton(type: "지도", image: "assets/image/AppleMap_logo.png", name: "애플지도", url: widget.shop.appleMap_url!, shop: widget.shop),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showPickupBottomSheet(context),
            child: Text(
              "지도 보러가기",
              style: TextStyle(
                color: picketColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 15), // 버튼 사이 간격
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: picketColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showDeliveryBottomSheet(context),
            child: Text(
              "배달 주문하기",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
