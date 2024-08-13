import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> setUserActivity(String location) async {
  final user = FirebaseAuth.instance.currentUser;

  await FirebaseFirestore.instance
      .collection("user_activity")
      .doc(user!.uid)
      .set({
    'location': location,
  });
}

Future<String> getUserActivity() async {
  final user = FirebaseAuth.instance.currentUser;
  String location;

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('user_activity')
      .doc(user!.uid)
      .get();

  if (snapshot.exists) {
    final data = snapshot.data() as Map<String, dynamic>;
    location = data['location'] as String;
  } else {
    location = 'Gangnam';
  }

  return location;
}

Future<String> getUserLocation() async {
  final user = FirebaseAuth.instance.currentUser;
  String location;
  String krLocation = "강남";

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('user_activity')
      .doc(user!.uid)
      .get();

  if (snapshot.exists) {
    final data = snapshot.data() as Map<String, dynamic>;
    location = data['location'] as String;
  } else {
    location = 'Gangnam';
  }

  switch (location) {
    case "Gangnam": krLocation = "강남";
    case "Gwanak": krLocation = "관악";
    case "Sinchon": krLocation = "서대문구";
  }

  return krLocation;
}