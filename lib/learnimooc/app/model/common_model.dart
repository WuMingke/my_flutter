class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar);

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      json["icon"],
      json["title"],
      json["url"],
      json["statusBarColor"],
      json["hideAppBar"],
    );
  }
}
