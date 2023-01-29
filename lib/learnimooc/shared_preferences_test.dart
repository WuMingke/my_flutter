import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceTest extends StatefulWidget {
  const SharedPreferenceTest({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceTest> createState() => _SharedPreferenceTestState();
}

class _SharedPreferenceTestState extends State<SharedPreferenceTest> {
  String countString = "";
  String localCount = "";

  _incrementCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = "${countString}1";
    });
    int count = (prefs.getInt("counter") ?? 0) + 1;
    await prefs.setInt("counter", count);
  }

  _getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = (prefs.get("counter") ?? 0).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _incrementCounter();
          },
          child: const Text("+"),
        ),
        Text(countString),
        ElevatedButton(
          onPressed: () {
            _getCounter();
          },
          child: const Text("-"),
        ),
        Text("localCount:$localCount"),
      ],
    );
  }
}
