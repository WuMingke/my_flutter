import 'package:flutter/material.dart';

/// 顶部导航
class TabbedAppBarSample extends StatelessWidget {
  const TabbedAppBarSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // 这里这样用应该可以用来代替ViewPager
      length: choices.length,
      child: TabBarView(
        children: choices
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(16),
                child: ChoiceCard(
                  choice: e,
                ),
              ),
            )
            .toList(),
      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Tabbed AppBar"),
      //     bottom: TabBar(
      //       tabs: choices
      //           .map((e) => Tab(
      //                 text: e.title,
      //                 icon: Icon(e.icon),
      //               ))
      //           .toList(),
      //     ),
      //   ),
      //   body: TabBarView(
      //     children: choices
      //         .map(
      //           (e) => Padding(
      //             padding: const EdgeInsets.all(16),
      //             child: ChoiceCard(
      //               choice: e,
      //             ),
      //           ),
      //         )
      //         .toList(),
      //   ),
      // ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;

  const Choice(this.title, this.icon);
}

const List<Choice> choices = [
  Choice("car", Icons.directions_car),
  Choice("bicycle", Icons.directions_bike),
  Choice("boat", Icons.directions_boat),
  Choice("bus", Icons.directions_bus),
  Choice("train", Icons.directions_train),
  Choice("walk", Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, required this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.displayMedium;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              choice.icon,
              size: 128,
              color: textStyle?.color,
            ),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
