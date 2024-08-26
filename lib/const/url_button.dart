import 'package:flutter/material.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/launch_url.dart';

import '../model/shops.dart';

class UrlButton extends StatefulWidget {
  String image;
  String url;
  String name;
  Shop shop;
  String type;

  UrlButton(
      {required this.type,
      required this.image,
      required this.name,
      required this.url,
      required this.shop,
      super.key});

  @override
  State<UrlButton> createState() => _UrlButtonState();
}

class _UrlButtonState extends State<UrlButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Image.asset(
            widget.image,
            width: 70,
            fit: BoxFit.fill,
          ),
          onPressed: () {
            if (widget.type == "배달") {
              Analytics_config().click_delivery(
                delivery_app: widget.name,
                menu_name: widget.shop.menu_name,
                menu_price: widget.shop.menu_price,
                store_rating_naver: widget.shop.store_rating_naver,
                store_rating_kakao: widget.shop.store_rating_kakao,
                store_name: widget.shop.store_name,
              );
            } else if (widget.type == "지도") {
              Analytics_config().click_map(
                map_app: widget.name,
                menu_name: widget.shop.menu_name,
                menu_price: widget.shop.menu_price,
                store_rating_naver: widget.shop.store_rating_naver,
                store_rating_kakao: widget.shop.store_rating_kakao,
                store_name: widget.shop.store_name,
              );
            }

            launchURL(widget.url);
          },
        ),
        Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
