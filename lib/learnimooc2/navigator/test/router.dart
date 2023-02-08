import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc2/navigator/core/my_navigator.dart';
import 'package:my_flutter/learnimooc2/navigator/test/my_detail_page.dart';
import 'package:my_flutter/learnimooc2/navigator/test/video_model.dart';

import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyRouteDelegate myRouteDelegate = MyRouteDelegate();

  @override
  Widget build(BuildContext context) {
    // 定义router
    // var router = Router(routerDelegate: myRouteDelegate);
    // return MaterialApp(
    //   home: router,
    // );

    return FutureBuilder(builder: (BuildContext context, AsyncSnapshot<Void> snapshot) {
      // 定义route
      StatefulWidget widget;
      // if (snapshot.connectionState == ConnectionState.done) {
      // TODO: 2023/2/8 mingKE 有问题
      widget = Router(routerDelegate: myRouteDelegate);
      // } else {
      //   widget = const Scaffold(
      //     body: Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // }
      return MaterialApp(
        home: widget,
      );
    });
  }
}

class MyRoutePath {
  final String location;

  MyRoutePath.home() : location = "/";

  MyRoutePath.detail() : location = "/detail";
}

class MyRouteDelegate extends RouterDelegate<MyRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  final GlobalKey<NavigatorState> myNavigatorKey;

  // 为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  MyRouteDelegate() : myNavigatorKey = GlobalKey<NavigatorState>() {
    // 实现路由跳转逻辑
    MyNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            videoModel = args?["viewModel"];
          }
          notifyListeners();
        },
      ),
    );
  }

  // 所有的页面
  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  // MyRoutePath? myRoutePath;
  RouteStatus _routeStatus = RouteStatus.home; // TODO: 2023/2/8 mingKE 这个属性赋值的地方，需要修改

  RouteStatus get routeStatus => _routeStatus; // 这里可以做路由拦截

  @override
  Widget build(BuildContext context) {
    int index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 如果有这个页面，只需要对其上面的页面出栈，不需要重新创建
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(MyHomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(MyDetailPage(videoModel: videoModel!));
    }

    // 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    pages = tempPages;
    // 构建路由栈
    // pages = [
    //   pageWrap(
    //     MyHomePage(
    //       onJumpToDetail: (videoModel) {
    //         this.videoModel = videoModel;
    //         notifyListeners();
    //       },
    //     ),
    //   ),
    //   if (videoModel != null) pageWrap(MyDetailPage(videoModel: videoModel!)),
    // ];
    return WillPopScope(
      onWillPop: () async {
        // 修复Android物理返回键，无法返回上一页的问题
        return !await navigatorKey!.currentState!.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          // 在这里控制是否可以返回上一页
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => myNavigatorKey;

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    // myRoutePath = configuration;
  }
}

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}
