import 'package:flutter/material.dart';

class MyNav extends StatelessWidget {
  const MyNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Container(
                  color: Colors.blue,
                  child: const Material(child: Text("this is a new page")),
                );
              },
            ),
          );
        },
        child: const Text("Open"),
      ),
    );
  }
}
