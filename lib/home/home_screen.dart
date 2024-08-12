import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickeat/home/food_slide.dart';

import '../enum/location.dart';
import '../model/shops.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Shop> shops = [];
  final db = FirebaseFirestore.instance;
  final location = Location.Sinchon;

  Future<List<Shop>> initialFireStore() async {
    var shopDB = await db.collection("store_db").get();
    for (var shop in shopDB.docs) {
      shops.add(Shop.fromJson(shop.data()));
    }

    return shops;
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Shop>>(
        future: initialFireStore(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData == false){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return FoodSlide(shops: shops);
          }
        },
      ),
    );
  }
}
