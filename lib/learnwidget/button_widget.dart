import 'package:flutter/material.dart';

class ButtonTest extends StatelessWidget {
  const ButtonTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("ElevatedButton")),
        TextButton(onPressed: () {}, child: const Text("TextButton")),
        OutlinedButton(onPressed: () {}, child: const Text("OutlinedButton")),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.connect_without_contact)),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.back_hand),
          label: const Text("ElevatedButton"),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.confirmation_num),
          label: const Text("OutlinedButton"),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.confirmation_num),
          label: const Text("TextButton"),
        ),
      ],
    );
  }
}
