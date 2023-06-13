import 'package:flutter/material.dart';

class MyList4 extends StatelessWidget {
  const MyList4({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        print('顶层');
        return false;
      },
      child: NotificationListener(
        onNotification: (notification) {
          print('内层');
          return true; // 是否拦截
        },
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.separated(
            itemBuilder: (_, index) => Container(
              height: 56,
              alignment: Alignment.center,
              child: Text("data $index"),
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 56,
          ),
        ),
      ),
    );
  }
}

/// 自定义Behavior
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Colors.red,
      child: child,
    );
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(parent: RangeMaintainingScrollPhysics());
  }
}
