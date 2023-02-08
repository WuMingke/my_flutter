import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc2/navigator/test/video_model.dart';

class MyDetailPage extends StatefulWidget {
  const MyDetailPage({Key? key, required this.videoModel}) : super(key: key);

  final VideoModel videoModel;

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("详情vid：${widget.videoModel.vid}"),
    );
  }
}
