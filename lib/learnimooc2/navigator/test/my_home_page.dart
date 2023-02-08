import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc2/navigator/core/my_navigator.dart';

import 'video_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.onJumpToDetail}) : super(key: key);

  final ValueChanged<VideoModel>? onJumpToDetail;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listener;

  @override
  void initState() {
    super.initState();
    listener = (RouteStatusInfo current, RouteStatusInfo? pre) {
      print("--current:${current.page}");
      print("--current:${pre?.page}");

      if (widget == current.page || current.page is MyHomePage) {
        print("打开了首页，onResume");
      } else if (widget == pre?.page || pre?.page is MyHomePage) {
        print("onPause");
      }
    };
    MyNavigator.getInstance().addListener(listener);
  }

  @override
  void dispose() {
    MyNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          const Text("首页"),
          MaterialButton(
            onPressed: () {
              widget.onJumpToDetail?.call(VideoModel(1)); // TODO: 2023/2/8 mingKE 这里可以用MyNavigator改造，不用callback的形式
            },
            child: const Text("详情"),
          ),
        ],
      ),
    );
  }
}
