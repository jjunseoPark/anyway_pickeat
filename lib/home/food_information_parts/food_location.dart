import 'package:flutter/material.dart';

import '../../model/shops.dart';

class FoodLocation extends StatefulWidget {
  Shop shop;

  FoodLocation({required this.shop,super.key});

  @override
  State<FoodLocation> createState() => _FoodLocationState();
}

class _FoodLocationState extends State<FoodLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(125, 125, 125, 0.4),
      ),
      height: 40,
      width: 320,
      child: Center(
        child: Text(
//store_address*************************************
          "${widget.shop.store_address!}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
