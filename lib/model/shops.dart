import 'package:freezed_annotation/freezed_annotation.dart';

part 'shops.freezed.dart';

part 'shops.g.dart';

@freezed
sealed class Shop with _$Shop {
  factory Shop({
    int? menu_id,
    String? menu_name,
    int? menu_price,
    String? store_name,
    String? store_address,
    double? store_rating_kakao,
    double? store_rating_naver,
    String? yogiyo_url,
    String? coupang_url,
    String? baemin_url,
    String? kakaoMap_url,
    String? naver_url,
    String? naverReview_url,
    int? store_count_naver,
    int? store_count_kakao,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
