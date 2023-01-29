import 'package:flutter/material.dart';

class ListTest extends StatefulWidget {
  const ListTest({Key? key}) : super(key: key);

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  var CITY_NAMES = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 50; i++) {
      CITY_NAMES.add("$i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildList(),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((name) => _buildListItem(name)).toList();
  }

  Widget _buildListItem(name) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(color: Colors.blue, fontSize: 20),
      ),
    );
  }
}

/// ////////////////////////////////////////////////////
///
class ExpansionTileTest extends StatefulWidget {
  const ExpansionTileTest({Key? key}) : super(key: key);

  @override
  State<ExpansionTileTest> createState() => _ExpansionTileTestState();
}

class _ExpansionTileTestState extends State<ExpansionTileTest> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildList(),
    );
  }

  static const CITY_NAMES = {
    '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
    '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
    '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
    '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
    '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
    '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
  };

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    for (var key in CITY_NAMES.keys) {
      widgets.add(_item(key, CITY_NAMES[key]!));
    }
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
      title: Text(
        city,
        style: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      children: subCities.map((subCity) => _buildSub(subCity)).toList(),
    );
  }

  Widget _buildSub(String subCity) {
    return FractionallySizedBox(
        widthFactor: 1, // 撑满一行
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(color: Colors.lightBlueAccent),
          child: Text(subCity),
        ));
  }
}

/// ////////////////////////////////////////////////////
///
class GridViewTest extends StatefulWidget {
  const GridViewTest({Key? key}) : super(key: key);

  @override
  State<GridViewTest> createState() => _GridViewTestState();
}

class _GridViewTestState extends State<GridViewTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5), // 均分
      child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
        children: _buildList(),
      ),
    );
  }

  var CITY_NAMES = ['北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨'];

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      // margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
