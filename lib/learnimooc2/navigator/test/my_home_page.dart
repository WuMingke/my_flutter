import 'package:flutter/material.dart';

import 'video_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.onJumpToDetail}) : super(key: key);

  final ValueChanged<VideoModel>? onJumpToDetail;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
