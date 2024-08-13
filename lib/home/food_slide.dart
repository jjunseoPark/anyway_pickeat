import 'dart:async';

import 'package:amplitude_flutter/identify.dart';
import 'package:flutter/material.dart';
import 'package:pickeat/analytic_config.dart';
import '../model/shops.dart';
import 'food_information.dart';
import 'food_player.dart';

class FoodSlide extends StatefulWidget {
  List<Shop> shops;

  FoodSlide({required this.shops, super.key});

  @override
  State<FoodSlide> createState() => _FoodSlideState();
}

class _FoodSlideState extends State<FoodSlide> {
  final PageController verticalPageController =
      PageController(initialPage: 1000, viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
    widget.shops.shuffle();
  }

  @override
  void dispose() {
    verticalPageController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.shops.length;


    return PageView.builder(
        scrollDirection: Axis.vertical,
        controller: verticalPageController,
        onPageChanged: (idx) {
          setState(() {
            Analytics_config().up();
            Analytics_config().swip();
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              FoodPlayer(shop: widget.shops[index % itemCount + 1]),
              FoodInformation(shop: widget.shops[index % itemCount + 1]),
            ],
          );
        });
  }
}
