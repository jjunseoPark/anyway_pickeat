// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
      menu_id: (json['menu_id'] as num?)?.toInt(),
      menu_name: json['menu_name'] as String?,
      menu_price: (json['menu_price'] as num?)?.toInt(),
      store_name: json['store_name'] as String?,
      store_address: json['store_address'] as String?,
      store_rating_kakao: (json['store_rating_kakao'] as num?)?.toDouble(),
      store_rating_naver: (json['store_rating_naver'] as num?)?.toDouble(),
      yogiyo_url: json['yogiyo_url'] as String?,
      coupang_url: json['coupang_url'] as String?,
      baemin_url: json['baemin_url'] as String?,
      appleMap_url: json['appleMap_url'] as String?,
      kakaoMap_url: json['kakaoMap_url'] as String?,
      naver_url: json['naver_url'] as String?,
      naverReview_url: json['naverReview_url'] as String?,
      store_count_naver: (json['store_count_naver'] as num?)?.toInt(),
      store_count_kakao: (json['store_count_kakao'] as num?)?.toInt(),
      store_latitude: (json['store_latitude'] as num?)?.toDouble(),
      store_longtitude: (json['store_longtitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'menu_id': instance.menu_id,
      'menu_name': instance.menu_name,
      'menu_price': instance.menu_price,
      'store_name': instance.store_name,
      'store_address': instance.store_address,
      'store_rating_kakao': instance.store_rating_kakao,
      'store_rating_naver': instance.store_rating_naver,
      'yogiyo_url': instance.yogiyo_url,
      'coupang_url': instance.coupang_url,
      'baemin_url': instance.baemin_url,
      'appleMap_url': instance.appleMap_url,
      'kakaoMap_url': instance.kakaoMap_url,
      'naver_url': instance.naver_url,
      'naverReview_url': instance.naverReview_url,
      'store_count_naver': instance.store_count_naver,
      'store_count_kakao': instance.store_count_kakao,
      'store_latitude': instance.store_latitude,
      'store_longtitude': instance.store_longtitude,
    };
