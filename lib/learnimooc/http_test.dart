import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHttpTest extends StatefulWidget {
  const MyHttpTest({Key? key}) : super(key: key);

  @override
  State<MyHttpTest> createState() => _MyHttpTestState();
}

class _MyHttpTestState extends State<MyHttpTest> {
  String showResult = "";

  Future<CommonModel> fetchPost() async {
    final response = await http.get(Uri.parse("http://www.devio.org/io/flutter_app/json/test_common_model.json"));
    final result = json.decode(const Utf8Decoder().convert(response.bodyBytes)); // 这里有中文乱码的处理
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    // 第二种方式
    return FutureBuilder<CommonModel>(
      future: fetchPost(),
      builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text("Input a URL to start");
          case ConnectionState.waiting:
            return const Text("waiting");
          case ConnectionState.active:
            return const Text("loading");
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(
                "error:${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return Text("result:${snapshot.data?.title ?? "未知"}");
            }
        }
      },
    );

    // 第一种方式
    // return Column(
    //   children: [
    //     InkWell(
    //       onTap: () {
    //         fetchPost().then((value) {
    //           setState(() {
    //             showResult = "title:${value.title}";
    //           });
    //         });
    //       },
    //       child: const Text("request"),
    //     ),
    //     Text(showResult),
    //   ],
    // );
  }
}

class CommonModel {
  String? icon;
  String? title;
  String? url;
  String? statusBarColor;
  bool? hideAppbar;

  CommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppbar});

  factory CommonModel.fromJson(Map<dynamic, dynamic> json) {
    return CommonModel(
      icon: json["icon"],
      title: json["title"],
      url: json["url"],
      statusBarColor: json["statusBarColor"],
      hideAppbar: json["hideAppbar"],
    );
  }
}
