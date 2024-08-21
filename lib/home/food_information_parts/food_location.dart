import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../function/user_activity.dart';
import '../../model/shops.dart';
import '../profile.dart';

class FoodLocation extends StatefulWidget {
  Shop shop;

  FoodLocation({required this.shop, super.key});

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
              title: Text(
                '서울시 강남구',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
              title: Text(
                '서울시 관악구',
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
              title: Text(
                '서울시 서대문구(신촌)',
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    },
  );
}

class _FoodLocationState extends State<FoodLocation> {
  double? latitude;
  double? longitude;
  double? shop_latitude;
  double? shop_longtitude;
  double? km;

  Future<void> getGeoData() async {
    try {
      // 위치 권한 확인 및 요청
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Permissions are denied');
        }
      }

      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition();

      // 위젯이 여전히 mounted 상태일 때만 setState 호출
      if (mounted) {
        setState(() {
          latitude = position.latitude.toDouble();
          longitude = position.longitude.toDouble();

          shop_latitude = widget.shop.store_latitude;
          shop_longtitude = widget.shop.store_longtitude;

          if (latitude != null && longitude != null && shop_latitude != null && shop_longtitude != null) {
            km = Distance().as(
                LengthUnit.Meter,
                LatLng(latitude!, longitude!),
                LatLng(shop_latitude!, shop_longtitude!)
            );
          }
        });
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    getGeoData();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => _showlocationBottomSheet(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.location_on_outlined,
              size: 35,
              color: Colors.white,
            ),
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
                  "서울시 ${snapshot.data}${km != null ? ' : ${(km!/1000.0).toStringAsFixed(1)} km' : ''}",
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
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen()), // ProfileScreen은 profile.dart에서 정의된 화면 클래스
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.person_outline,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
