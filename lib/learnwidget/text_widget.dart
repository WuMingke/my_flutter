import 'package:flutter/material.dart';

class TextTest extends StatelessWidget {
  const TextTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello World",
          textAlign: TextAlign.end,
        ),
        const Text(
          "Hello world! I'm Jack. Hello world! I'm Jack.Hello world! I'm Jack.Hello world! I'm Jack.",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Text(
          "Hello Wold",
          textScaleFactor: 1.8,
        ),
        Text(
          "Style",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontFamily: "Courier",
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
        const Text.rich(TextSpan(children: [
          TextSpan(text: "home:"),
          TextSpan(
            text: "www.baidu.com",
            style: TextStyle(color: Colors.blueAccent),
          )
        ])),
        DefaultTextStyle(
            style: const TextStyle(color: Colors.red, fontSize: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("data"),
                Text("dddd"),
                Text(
                  "no data",
                  style: TextStyle(inherit: false, color: Colors.amber),
                )
              ],
            )),
      ],
    );
  }
}
