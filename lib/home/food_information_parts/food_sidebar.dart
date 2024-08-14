import 'package:flutter/material.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/model/shops.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:pickeat/home/profile.dart';

import '../../const/launch_url.dart';

class FoodSidebar extends StatefulWidget {
  Shop shop;

  FoodSidebar({required this.shop, super.key});

  @override
  State<FoodSidebar> createState() => _FoodSidebarState();
}

class _FoodSidebarState extends State<FoodSidebar> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      Analytics_config().click_like(
        menu_name: widget.shop.menu_name,
        menu_price: widget.shop.menu_price,
        store_rating_naver: widget.shop.store_rating_naver,
        store_rating_kakao: widget.shop.store_rating_kakao,
        store_name: widget.shop.store_name,
      );
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          transform: Matrix4.translationValues(20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: _toggleFavorite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // 터치 영역을 넓히기 위해 padding 추가
                  child: Column(
                    children: [
                      Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        '좋아요',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//               SizedBox(height: 20),
//               IconButton(
//                 icon: Icon(
//                   Icons.send,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
// //naverReview_url*************************************
//                   launchURL(widget.shop.naverReview_url!);
//                 },
//                 visualDensity: VisualDensity.compact,
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(
//                   minHeight: 0,
//                   minWidth: 0,
//                 ),
//               ),
//               Text(
//                 '공유',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Analytics_config().click_review(
                    menu_name: widget.shop.menu_name,
                    menu_price: widget.shop.menu_price,
                    store_rating_naver: widget.shop.store_rating_naver,
                    store_rating_kakao: widget.shop.store_rating_kakao,
                    store_name: widget.shop.store_name,
                  );
                  launchURL(widget.shop.naverReview_url!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // 터치 영역을 넓히기 위해 padding 추가
                  child: Column(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Icon(
                          Icons.web,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '리뷰',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
