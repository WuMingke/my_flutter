import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SearchBar(
            enabled: true,
            hideLeft: true,
            searchBarType: SearchBarType.normal,
            hint: "网红打卡地 景点 酒店 美食",
            leftBtnClick: () {},
            rightBtnClick: () {},
            speakClick: () {},
            inputBoxClick: () {},
            onChanged: _onChanged,
            defaultText: "",
          ),
          const Text("SearchPage"),
        ],
      )),
    );
  }

  _onChanged(String text) {
    if (text.isEmpty) {
      log(1);
    }
  }
}
