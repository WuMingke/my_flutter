import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
