import 'package:flutter/material.dart';

class MySync extends StatelessWidget {
  const MySync({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CircularProgressIndicator(),
          // ColorfulIndicator(),
          Transform.rotate(
            angle: 49,
            child: const LinearProgressIndicator(
              value: 0.5,
              minHeight: 20,
              valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
              backgroundColor: Colors.green,
            ),
          ),
          const LinearProgressIndicator(
            value: 0.5,
            minHeight: 20,
            valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
            backgroundColor: Colors.green,
          ),
          FutureBuilder(
            future: Future.value(123),
            initialData: 1,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Text('${snapshot.data}');
            },
          ),
        ],
      ),
    );
  }
}

class ColorfulIndicator extends StatefulWidget {
  const ColorfulIndicator({super.key});

  @override
  State<ColorfulIndicator> createState() => _ColorfulIndicatorState();
}

class _ColorfulIndicatorState extends State<ColorfulIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: ColorTween(
        begin: Colors.greenAccent,
        end: Colors.red,
      ).animate(_controller),
    );
  }
}
