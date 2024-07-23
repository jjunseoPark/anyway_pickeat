import 'package:freezed_annotation/freezed_annotation.dart';

part 'shops.freezed.dart';
part 'shops.g.dart';

@freezed
sealed class Shop with _$Shop{
  factory Shop({
    String? shopId,
    double? kakaoRating,
    double? naverRating,
    String? kakaoURL,
    String? naverURL,
    String? image,
    String? name,
    List<Menu>? menuList,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}

@freezed
sealed class Menu with _$Menu {
  factory Menu({
    String? menuID,
    String? name,
    String? description,
    double? price,
    String? Video,
    String? BaeminURL,
    String? CoopangURL,
  }) = _Menu;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}