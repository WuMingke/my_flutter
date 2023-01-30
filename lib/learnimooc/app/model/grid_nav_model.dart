import 'package:my_flutter/learnimooc/app/model/common_model.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel(this.hotel, this.flight, this.travel);

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      GridNavItem.fromJson(json["hotel"]),
      GridNavItem.fromJson(json["flight"]),
      GridNavItem.fromJson(json["travel"]),
    );
  }
}

class GridNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(this.startColor, this.endColor, this.mainItem, this.item1, this.item2, this.item3, this.item4);

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      json["startColor"],
      json["endColor"],
      CommonModel.fromJson(json["mainItem"]),
      CommonModel.fromJson(json["item1"]),
      CommonModel.fromJson(json["item2"]),
      CommonModel.fromJson(json["item3"]),
      CommonModel.fromJson(json["item4"]),
    );
  }
}
