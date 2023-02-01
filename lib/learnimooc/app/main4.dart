import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/navigator/tab_navigator.dart';

import '../extensions.dart';

void main() {
  runApp(const Main());

  // 全局状态栏透明
  changeStatusBarColor(Colors.transparent, Brightness.light);
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TabNavigator(),
      ),
    );
  }
}
