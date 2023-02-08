import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc2/navigator/test/my_detail_page.dart';

import '../test/my_home_page.dart';

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}

/// 获取routeStatus在页面中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getRouteStatus(page) == status) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由封装，路由状态
enum RouteStatus { login, registration, home, detail, unKnow }

/// 获取page对应的RouteStatus
RouteStatus getRouteStatus(MaterialPage page) {
  var child = page.child;
  if (child is MyHomePage) {
    return RouteStatus.home;
  } else if (child is MyDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unKnow;
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

/// 监听路由页面跳转
/// 感知当前页面是否压后台
class MyNavigator extends _RouteJumpListener {
  MyNavigator._();
  static MyNavigator? _instance;
  static MyNavigator getInstance() {
    _instance ??= MyNavigator._();
    return _instance!;
  }

  RouteJumpListener? _jumpListener;

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener listener) {
    _jumpListener = listener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _jumpListener?.onJumpTo?.call(routeStatus, args: args);
  }
}

/// 抽象类供MyNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

/// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
