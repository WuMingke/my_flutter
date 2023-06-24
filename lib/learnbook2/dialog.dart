import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("To delete"),
              content: const Text("delete ?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("confirm"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("cancel"),
                ),
              ],
            );
          },
        );
        print("result=== $result");
      },
      child: const Text("show dialog"),
    );
  }
}
