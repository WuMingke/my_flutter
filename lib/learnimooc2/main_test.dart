import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc2/http/core/error_manager.dart';
import 'package:my_flutter/learnimooc2/http/core/request_manager.dart';
import 'package:my_flutter/learnimooc2/http/request/test_request.dart';

import 'cache/project_cache.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    ProjectCache.preInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: InkWell(
              onTap: () async {
                // 这里async-await保证了执行顺序
                var req = TestRequest();
                req.add("k", "v").add("requestPrams", "v");
                try {
                  var result = await RequestManager().fire(req);
                  print("---result 1:$result");
                } on ReqError catch (e) {
                  print("---result error 1:${e.toString()}");
                } catch (e) {
                  print("---result error 2:${e.toString()}");
                }
                ProjectCache().setString("aa", "123");
                String resultStr = ProjectCache().get("aa");
                print("---resultStr:$resultStr");
              },
              child: Text("11111"),
            ),
          ),
        ),
      ),
    );
  }
}
