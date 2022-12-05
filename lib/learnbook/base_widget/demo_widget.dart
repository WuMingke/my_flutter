import 'package:flutter/material.dart';

class DemoWidget extends StatelessWidget {
  // String text = "";

  const DemoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          color: Colors.blue,
          child: const Text(
            "StatelessWidget",
            textDirection: TextDirection.ltr,
            // style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}

class SimpleFutureBuilder extends StatelessWidget {
  const SimpleFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getNetworkData() async {
      await Future.delayed(const Duration(seconds: 5));
      return "123";
    }

    return MaterialApp(
      home: SafeArea(
        child: FutureBuilder(
            future: getNetworkData(),
            initialData: "0000",
            builder: (BuildContext context, AsyncSnapshot<String?> data) {
              return Text(data.requireData ?? "loading");
            }),
      ),
    );
  }
}
