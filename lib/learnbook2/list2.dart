import 'package:flutter/material.dart';

class MyList2 extends StatelessWidget {
  MyList2({super.key});

  final data = List.generate(30, (index) => index);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      // physics: AutoScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: ColoredBox(
            color: Colors.blue,
            child: Text('data:$index'),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
          width: 10,
        );
      },
      itemCount: data.length,
    );
  }
}

// TODO: 2023/6/12 mingKE 自定义滑动的物理模型，这里有问题
class AutoScrollPhysics extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AutoScrollPhysics();
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return false;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    return AutoScrollSimulation();
  }
}

class AutoScrollSimulation extends Simulation {
  double velocity = 200.0;
  double total = 0;
  @override
  double x(double time) {
    return velocity * time;
  }

  @override
  bool isDone(double time) {
    return false;
  }

  @override
  double dx(double time) {
    return velocity;
  }
}
