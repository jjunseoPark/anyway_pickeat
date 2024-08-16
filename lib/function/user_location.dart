import 'package:geolocator/geolocator.dart';

Future<Position> getUserPosition() async{

  // 위치 정보 획득 가능한지 확인
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // 위치 추적 퍼미션 확인
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('permissions are denied');
    }
  }

  // 현재 위치 구하기
  Position position = await Geolocator.getCurrentPosition();

  return position;
}