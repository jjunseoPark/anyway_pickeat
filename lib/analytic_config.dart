import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';
import 'package:flutter/material.dart';

class Analytics_config {
  static late Amplitude analytics =
      Amplitude.getInstance(instanceName: "anyway");

  final Identify identify = Identify();

  Future<void> init() async {
    // Initialize SDK
    analytics.init('9c0aea79c221102ff0f9da764a3cdd93');

    identify..set('swipe', 0);
    Analytics_config.analytics.identify(identify);
  }


  Future<void> up() async {
    identify.add('swipe', 1);
    Analytics_config.analytics.identify(identify);
  }


  //EVENT

  Future<void> swip() async {
    analytics.logEvent('swipe');
  }

  Future<void> login() async{
    analytics.logEvent('log_in');
  }

  Future<void> viewLogin() async{
    analytics.logEvent('view_login');
  }

  Future<void> viewSignup() async{
    analytics.logEvent('view_signup');
  }

  Future<void> signup() async{
    analytics.logEvent('signup');
  }

  Future<void> play_video({required menu_name, required menu_price, required store_rating_naver, required store_rating_kakao, required store_name}) async{
    analytics.logEvent('play_video', eventProperties: {
      'menu_name': menu_name,
      'menu_price': menu_price,
      'store_rating_naver': store_rating_naver,
      'store_rating_kakao': store_rating_kakao,
      'store_name': store_name,
    });
  }

  Future<void> click_delivery({required delivery_app , required menu_name, required menu_price, required store_rating_naver, required store_rating_kakao, required store_name}) async{
    analytics.logEvent('click_delivery', eventProperties: {
      'delivery_app': delivery_app,
      'menu_name': menu_name,
      'menu_price': menu_price,
      'store_rating_naver': store_rating_naver,
      'store_rating_kakao': store_rating_kakao,
      'store_name': store_name,
    });
  }

  Future<void> click_map({required map_app ,required menu_name, required menu_price, required store_rating_naver, required store_rating_kakao, required store_name}) async{
    analytics.logEvent('click_map', eventProperties: {
      'map_app': map_app,
      'menu_name': menu_name,
      'menu_price': menu_price,
      'store_rating_naver': store_rating_naver,
      'store_rating_kakao': store_rating_kakao,
      'store_name': store_name,
    });
  }

  Future<void> click_review({required menu_name, required menu_price, required store_rating_naver, required store_rating_kakao, required store_name}) async{
    analytics.logEvent('click_review', eventProperties: {
      'menu_name': menu_name,
      'menu_price': menu_price,
      'store_rating_naver': store_rating_naver,
      'store_rating_kakao': store_rating_kakao,
      'store_name': store_name,
    });
  }

  Future<void> click_like({required menu_name, required menu_price, required store_rating_naver, required store_rating_kakao, required store_name}) async{
    analytics.logEvent('click_like', eventProperties: {
      'menu_name': menu_name,
      'menu_price': menu_price,
      'store_rating_naver': store_rating_naver,
      'store_rating_kakao': store_rating_kakao,
      'store_name': store_name,
    });
  }


}
