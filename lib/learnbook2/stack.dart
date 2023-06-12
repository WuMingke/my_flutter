import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MyStack extends StatefulWidget {
  const MyStack({super.key});

  @override
  State<MyStack> createState() => _MyStackState();
}

class _MyStackState extends State<MyStack> {
  bool isGreen = false;
  String url =
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F4d2a8885-131d-4530-835a-0ee12ae4201b%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1689132205&t=e1049fb207feed5aba81f93c5021bc70';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isGreen = true;
        url =
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202106%2F22%2F20210622154903_3c36a.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1689132204&t=238d796d6f3a792359c8c90b6adb3c9d';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView(
        children: [
          FadeInImage(
            placeholder: const AssetImage("images/head.jpg"),
            image: NetworkImage(url),
          ),
          Image.network(
            url,
            gaplessPlayback: true,
            frameBuilder: (
              BuildContext context,
              Widget child,
              int? frame,
              bool wasSynchronouslyLoaded,
            ) {
              // if (frame == null) {
              //   return const SizedBox(
              //     width: 200,
              //     height: 200,
              //     child: Text('loading'),
              //   );
              // }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 3),
                child: child,
              );
            },
          ),
          Image.asset(
            '',
            gaplessPlayback: true,
          ),
          Image.network(
            url,
            gaplessPlayback: true,
            errorBuilder: (_, __, ___) {
              return const Text('出错啦～～');
            },
          ),
          RichText(
            text: const TextSpan(
              text: '123',
              style: TextStyle(color: Colors.red),
              children: [
                TextSpan(
                  text: '456',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: '789',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          AnimatedDefaultTextStyle(
            style: TextStyle(
              color: isGreen ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            duration: const Duration(seconds: 3),
            child: const Text('123'),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('data1'),
                Text('data2'),
                Text('data3'),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: 200,
            height: 200,
            child: Text(
              'qqqqqqqqq',
              softWrap: false,
              overflow: TextOverflow.visible,
              textScaleFactor: 1.5,
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    Offset.zero,
                    const Offset(200, 0),
                    [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.greenAccent,
            child: const SizedBox(
              width: 100,
              height: 100,
              child: FlutterLogo(),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.grey.shade200,
            child: Stack(
              children: const [
                Positioned(
                  left: 20,
                  top: 20,
                  width: 50,
                  height: 50,
                  child: FlutterLogo(),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: FlutterLogo(),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: FlutterLogo(),
                ),
                Positioned(
                  left: 100,
                  right: 20,
                  top: 100,
                  bottom: 20,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
