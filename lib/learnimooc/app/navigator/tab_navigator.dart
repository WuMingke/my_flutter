import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/pages/home_page.dart';
import 'package:my_flutter/learnimooc/app/pages/my_page.dart';
import 'package:my_flutter/learnimooc/app/pages/search_page.dart';
import 'package:my_flutter/learnimooc/app/pages/travel_page.dart';
import 'package:my_flutter/learnimooc/extensions.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController();
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          if (index != 0) {
            changeStatusBarColor(Colors.transparent, Brightness.dark);
          } else {
            changeStatusBarColor(Colors.transparent, Brightness.light);
          }
        },
        children: const [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor,
            ),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            label: "搜索",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.camera_alt_outlined,
              color: _activeColor,
            ),
            label: "旅拍",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: _activeColor,
            ),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
