import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile.dart';



class FoodTopbar extends StatefulWidget {
  const FoodTopbar({super.key});



  @override
  State<FoodTopbar> createState() => _FoodTopbarState();
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
                Navigator.pop(context);
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
                Navigator.pop(context);
                // 여기에 현재 위치에 대한 로직을 추가할 수 있습니다.
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('서울시 마포구',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
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

class _FoodTopbarState extends State<FoodTopbar> {
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
