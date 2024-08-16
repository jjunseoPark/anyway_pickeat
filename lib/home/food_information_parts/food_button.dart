import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pickeat/model/shops.dart';

import '../../const/color.dart';

class FoodButton extends StatefulWidget {
  final Shop shop;

  FoodButton({required this.shop, super.key});

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
                  color: Color(0xfff6f6f6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // coupang_url
                      if (widget.shop.coupang_url != null && widget.shop.coupang_url!.isNotEmpty)
                        UrlButton(
                            type: "배달",
                            image: "assets/image/coupang_logo.png",
                            name: "쿠팡 이츠",
                            url: widget.shop.coupang_url!),
                      // yogiyo_url
                      if (widget.shop.yogiyo_url != null && widget.shop.yogiyo_url!.isNotEmpty)
                        UrlButton(
                            type: "배달",
                            image: "assets/image/yogiyo_logo.png",
                            name: "요기요",
                            url: widget.shop.yogiyo_url!),
                      // baemin_url
                      if (widget.shop.baemin_url != null && widget.shop.baemin_url!.isNotEmpty)
                        UrlButton(
                            type: "배달",
                            image: "assets/image/baemin_logo.png",
                            name: "배달의 민족",
                            url: widget.shop.baemin_url!),
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
                  color: Color(0xfff6f6f6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // naver_url
                      if (widget.shop.naver_url != null && widget.shop.naver_url!.isNotEmpty)
                        UrlButton(
                            type: "지도",
                            image: "assets/image/Naver_logo.png",
                            name: "네이버지도",
                            url: widget.shop.naver_url!),
                      // kakaoMap_url
                      if (widget.shop.kakaoMap_url != null && widget.shop.kakaoMap_url!.isNotEmpty)
                        UrlButton(
                            type: "지도",
                            image: "assets/image/Kakao_logo.png",
                            name: "카카오지도",
                            url: widget.shop.kakaoMap_url!),
                      // AppleMap_url
                      if (widget.shop.appleMap_url != null &&
                          widget.shop.appleMap_url!.isNotEmpty &&
                          Platform.isIOS)
                        UrlButton(
                            type: "지도",
                            image: "assets/image/AppleMap_logo.png",
                            name: "애플지도",
                            url: widget.shop.appleMap_url!),
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

class UrlButton extends StatelessWidget {
  final String type;
  final String image;
  final String name;
  final String url;

  UrlButton({
    required this.type,
    required this.image,
    required this.name,
    required this.url,
  });

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Column(
        children: [
          Image.asset(image, width: 50, height: 50),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
