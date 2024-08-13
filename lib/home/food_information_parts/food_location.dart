import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../function/user_activity.dart';
import '../../model/shops.dart';
import '../profile.dart';

class FoodLocation extends StatefulWidget {
  Shop shop;

  FoodLocation({required this.shop,super.key});

  @override
  State<FoodLocation> createState() => _FoodLocationState();
}

void _showlocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '지역을 선택하세요',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('서울시 강남구',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {
                setUserActivity("Gangnam");
                Navigator.pop(context);
                context.push('/login');
                // 여기에 선택한 위치에 대한 로직을 추가할 수 있습니다.
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('서울시 관악구',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                setUserActivity("Gwanak");
                Navigator.pop(context);
                context.push('/login');
                // 여기에 현재 위치에 대한 로직을 추가할 수 있습니다.
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('서울시 서대문구',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                setUserActivity("Sinchon");
                Navigator.pop(context);
                context.push('/login');
                // 여기에 지도를 사용한 위치 선택 로직을 추가할 수 있습니다.
              },
            ),
            SizedBox(height: 20,)
          ],
        ),
      );
    },
  );
}



class _FoodLocationState extends State<FoodLocation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => _showlocationBottomSheet(context),
          icon: Icon(
            Icons.location_on_outlined,
            size: 35,
            color: Colors.white,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromRGBO(125, 125, 125, 0.4),
          ),
          height: 40,
          width: 200,
          child: Center(
            child: FutureBuilder(
              future: getUserLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  //store_address*************************************
                  "서울시 ${snapshot.data}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.person_outline,
            size: 35,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()), // ProfileScreen은 profile.dart에서 정의된 화면 클래스
            );
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minHeight: 0,
            minWidth: 0,
          ),
        ),
      ],
    );
  }
}
