import 'package:flutter/material.dart';

class ScrollWidgetTest extends StatelessWidget {
  const ScrollWidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TestListView3();
    // return const Scrollbar(
    //     child: SingleChildScrollView(
    //   // padding: EdgeInsets.all(16),
    //   child: Center(
    //     // child: Test1(),
    //     // child: ListViewTest(),
    //     child: TestListView2(),
    //   ),
    // ));
  }
}

class TestListView3 extends StatelessWidget {
  const TestListView3({Key? key}) : super(key: key);

  final Widget divider1 = const Divider(color: Colors.blue);
  final Widget divider2 = const Divider(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text("$index"),
      ),
      separatorBuilder: (BuildContext context, int index) => index % 2 == 0 ? divider1 : divider2,
      itemCount: 100,
    );
  }
}

class TestListView2 extends StatelessWidget {
  const TestListView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      prototypeItem: const Text("111"),
      itemCount: 100,
      // itemExtent: 40,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
        );
      },
    );
  }
}

class Test1 extends StatelessWidget {
  final String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  const Test1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: str
          .split("")
          .map((c) => Text(
                c,
                textScaleFactor: 2.0,
              ))
          .toList(),
    );
  }
}

class ListViewTest extends StatelessWidget {
  const ListViewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: const [
        Text("data"),
        Text("data"),
        Text("data"),
        Text("data"),
      ],
    );
  }
}
