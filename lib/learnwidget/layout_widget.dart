import 'package:flutter/material.dart';

class TestPosition extends StatelessWidget {
  const TestPosition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.loose,
        children: [
          Container(
            color: Colors.red,
            child: const Text(
              "Hello world",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Positioned(
            left: 18.0,
            child: Text("I am Jack"),
          ),
          const Positioned(
            top: 50.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}

class TestLayout extends StatelessWidget {
  const TestLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget redBox = const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    Widget wrapperSizeBox = SizedBox(
      width: 100,
      height: 100,
      child: redBox,
    );

    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 20.0, maxHeight: 10.0),
          child: wrapperSizeBox,
        ));
  }
}

class FlexLayoutTestRoute extends StatelessWidget {
  const FlexLayoutTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
