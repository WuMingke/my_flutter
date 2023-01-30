import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/model/config_model.dart';
import 'package:my_flutter/learnimooc/app/model/grid_nav_model.dart';
import 'package:my_flutter/learnimooc/app/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(this.config, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox);

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json["bannerList"] as List; // TODO: 2023/1/30 mingKE 这里怎么就直接转了？？
    List<CommonModel> bannerList = bannerListJson
        .map(
          (e) => CommonModel.fromJson(e),
        )
        .toList();

    var localNavListJson = json["localNavList"] as List;
    List<CommonModel> localNavList = localNavListJson
        .map(
          (e) => CommonModel.fromJson(e),
        )
        .toList();

    var subNavListJson = json["subNavList"] as List;
    List<CommonModel> subNavList = subNavListJson
        .map(
          (e) => CommonModel.fromJson(e),
        )
        .toList();

    return HomeModel(
      ConfigModel.fromJson(json["config"]),
      bannerList,
      localNavList,
      subNavList,
      GridNavModel.fromJson(json["gridNav"]),
      SalesBoxModel.fromJson(json["salesBox"]),
    );
  }
}
