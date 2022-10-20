import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestCheckBox extends StatefulWidget {
  const TestCheckBox({Key? key}) : super(key: key);

  @override
  State<TestCheckBox> createState() => _TestCheckBoxState();
}

class _TestCheckBoxState extends State<TestCheckBox> {
  bool _switchSelect = false;
  bool _checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("-------------$_checkboxSelected");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Switch(
            value: _switchSelect,
            onChanged: (value) {
              setState(() {
                _switchSelect = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            })
      ],
    );
  }
}
