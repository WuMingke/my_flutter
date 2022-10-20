import 'package:flutter/material.dart';

class TextFieldTest extends StatelessWidget {
  const TextFieldTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TextField()],
    );
  }
}
