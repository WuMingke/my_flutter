import 'dart:math';

import 'package:flutter/material.dart';

class ContainerTest3 extends StatelessWidget {
  const ContainerTest3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget wContainer(BoxFit f) {
      return Container(
        width: 50,
        height: 50,
        color: Colors.red,
        child: FittedBox(
          fit: f,
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blueAccent,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              wContainer(BoxFit.none),
              const Text("123"),
              wContainer(BoxFit.contain),
              const Text("456"),
            ],
          ),
        )
      ],
    );
  }
}

class ContainerTest2 extends StatelessWidget {
  const ContainerTest2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget head = Image.asset(
      "images/head.jpg",
      width: 60,
      height: 60,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
          ),
          transform: Matrix4.rotationZ(.2),
          child: const Text("123"),
        ),
        const SizedBox(
          height: 50,
        ),
        ClipOval(
          child: head,
        ),
        ClipRect(
          child: head,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: head,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              widthFactor: .5,
              child: head,
            ),
            const Text(
              "你好世界",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,
                child: head,
              ),
            ),
            const Text(
              "你好世界",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        ClipRect(
          clipper: MyClipper(),
          child: head,
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ContainerTest extends StatelessWidget {
  const ContainerTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.skewY(0.3),
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.green,
            child: const Text("Apartment for rent!"),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.translate(
            offset: const Offset(20, 5),
            child: const Text("Hello World!"),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            angle: pi / 2,
            child: const Text("1231231"),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 3,
            child: const Text("1231231"),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: RotatedBox(
            quarterTurns: 1,
            child: Text("1231231"),
          ),
        ),
      ],
    );
  }
}
