import 'package:flutter/material.dart';

class FoodLocation extends StatefulWidget {
  const FoodLocation({super.key});

  @override
  State<FoodLocation> createState() => _FoodLocationState();
}

class _FoodLocationState extends State<FoodLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
