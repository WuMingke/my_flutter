class VodData {
  VodData._internal();

  factory VodData() => _instance;
  static late final VodData _instance = VodData._internal();

  List<ProgramInfo> tempData() {
    return List.generate(
        10,
        (index) => ProgramInfo(
              id: index,
              title: "标题$index",
              intro: "简介$index",
              giftUrl: "https://img.syt5.com/2021/0720/20210720092412855.jpg.420.420.jpg",
              giftPrice: "$index",
              tags1: "1-$index",
              tags2: "2-$index",
              buyNum: index * 2,
              state: 1,
            ));
  }
}

class ProgramInfo {
  final int id;
  final String title;
  final String intro;
  final String giftUrl;
  final String giftPrice;
  final String tags1;
  final String tags2;
  final int buyNum;
  final int state;

  ProgramInfo({
    required this.id,
    required this.title,
    required this.intro,
    required this.giftUrl,
    required this.giftPrice,
    required this.tags1,
    required this.tags2,
    required this.buyNum,
    required this.state,
  });
}
