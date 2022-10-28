import 'package:flutter/material.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("notice"),
      content: const Text("data"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text("confirm"),
        ),
      ],
    );
  }
}

class TestStream extends StatelessWidget {
  const TestStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1), (i) {
          return i;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('没有Stream');
            case ConnectionState.waiting:
              return const Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return const Text('Stream 已关闭');
          }
        },
      ),
    );
  }
}

class TestFuture extends StatelessWidget {
  const TestFuture({Key? key}) : super(key: key);

  Future<String> mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 3), () => "网上获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    print("build build build build build build build");
    return Center(
      child: FutureBuilder(
        future: mockNetworkData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

/// ***************Provider*********************/
class InheritedProvider<T> extends InheritedWidget {
  final T data;

  const InheritedProvider(this.data, {super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class ChangeNotifier extends Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    for (var element in listeners) {
      element();
    }
  }
}

// 订阅者
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  const ChangeNotifierProvider({super.key, required this.child, required this.data});

  static T? of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider?.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(widget.data, child: widget.child);
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }
}

/// ***************Provider*********************/

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetTestRoute> createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        _count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            ElevatedButton(
              child: const Text("click"),
              onPressed: () {
                setState(() {
                  ++_count;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  const _TestWidget({Key? key}) : super(key: key);

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // return Text(ShareDataWidget.of(context)?.data.toString() ?? "");
    return Text("13");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("change change...");
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data;

  const ShareDataWidget(this.data, {super.key, required super.child});

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class TestWillPop extends StatefulWidget {
  const TestWillPop({Key? key}) : super(key: key);

  @override
  State<TestWillPop> createState() => _TestWillPopState();
}

class _TestWillPopState extends State<TestWillPop> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: const Text("exit"),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 10)) {
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        });
  }
}
