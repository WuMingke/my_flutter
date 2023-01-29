import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/learnimooc/app/navigator/tab_navigator.dart';

void main() {
  runApp(const Main());

  // 全局状态栏透明
  if (Platform.isAndroid) {
    const systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
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
