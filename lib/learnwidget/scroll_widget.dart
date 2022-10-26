import 'package:flutter/material.dart';

class ScrollWidgetTest extends StatelessWidget {
  const ScrollWidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TestTwoListView2();
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

class TestTwoListView3 extends StatefulWidget {
  const TestTwoListView3({Key? key}) : super(key: key);

  @override
  State<TestTwoListView3> createState() => _TestTwoListView3State();
}

class _TestTwoListView3State extends State<TestTwoListView3> {
  @override
  Widget build(BuildContext context) {
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        // TODO: 2022/10/26 mingKE 自定义Sliver
        // SliverFlexibleHeader(),
        listView,
      ],
    );
  }
}

class TestTwoListView2 extends StatefulWidget {
  const TestTwoListView2({Key? key}) : super(key: key);

  @override
  State<TestTwoListView2> createState() => _TestTwoListView2State();
}

class _TestTwoListView2State extends State<TestTwoListView2> {
  @override
  Widget build(BuildContext context) {
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    // 使用
    return CustomScrollView(
      slivers: [
        listView,
        const SliverToBoxAdapter(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        listView,
      ],
    );
  }
}

class TestTwoListView extends StatefulWidget {
  const TestTwoListView({Key? key}) : super(key: key);

  @override
  State<TestTwoListView> createState() => _TestTwoListViewState();
}

class _TestTwoListViewState extends State<TestTwoListView> {
  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => ListTile(
              title: Text("$index"),
            ));
    return Column(
      children: [
        Expanded(child: listView),
        const Divider(
          color: Colors.grey,
        ),
        Expanded(child: listView),
      ],
    );
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < 6; ++i) {
      children.add(Page(text: '$i'));
    }

    return PageView(
      scrollDirection: Axis.vertical,
      children: children,
    );
  }
}

class Page extends StatefulWidget {
  final String text;

  const Page({Key? key, required this.text}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.text, textScaleFactor: 5));
  }
}

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({Key? key}) : super(key: key);

  @override
  State<AnimatedListRoute> createState() => _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {
  final _data = <String>[];
  int counter = 5;
  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < counter; i++) {
      _data.add('${i + 1}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: globalKey,
          initialItemCount: _data.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, index),
            );
          },
        ),
        buildAddBtn(),
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    String char = _data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => {
          onDelete(context, index),
        },
      ),
    );
  }

  void onDelete(BuildContext context, int index) {
    setState(() {
      globalKey.currentState?.removeItem(
        index,
        (context, animation) {
          // 删除过程执行的是反向动画，animation.value 会从1变为0
          var item = buildItem(context, index);
          _data.removeAt(index);
          // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              //让透明度变化的更快一些
              curve: const Interval(0.5, 1.0),
            ),
            // 不断缩小列表项的高度
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        duration: const Duration(milliseconds: 200), // 动画时间为 200 ms
      );
    });
  }

  Widget buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _data.add("${++counter}");
          globalKey.currentState?.insertItem(_data.length - 1);
        },
      ),
    );
  }
}

class ScrollNotificationTestRoute extends StatefulWidget {
  const ScrollNotificationTestRoute({Key? key}) : super(key: key);

  @override
  State<ScrollNotificationTestRoute> createState() => _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState extends State<ScrollNotificationTestRoute> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
              itemCount: 100,
              itemExtent: 30,
              itemBuilder: (context, index) => ListTile(title: Text("$index")),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Text(_progress),
            ),
          ],
        ),
      ),
    );
  }
}

class TestListView4 extends StatefulWidget {
  const TestListView4({Key? key}) : super(key: key);

  @override
  State<TestListView4> createState() => _TestListView4State();
}

class _TestListView4State extends State<TestListView4> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滚动控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50,
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(
                  0,
                  duration: const Duration(microseconds: 1500),
                  curve: Curves.ease,
                );
              },
            ),
    );
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
