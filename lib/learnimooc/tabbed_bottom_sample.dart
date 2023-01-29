import 'package:flutter/material.dart';

// 底部导航
class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: [],
      ),
    );
  }
}
