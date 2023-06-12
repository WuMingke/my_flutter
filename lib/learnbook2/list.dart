import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemExtent: 80,
      itemBuilder: (context, index) {
        // return Counter(
        //   index: index,
        // );
        return BlocProvider(
          create: (context) => CounterBloc(),
          child: MyCounter(index: index),
        );
      },
    );
  }
}

/// *************************** bloc ********************************

enum CounterEvent {
  increment,
}

class CounterState {
  int count = 0;

  CounterState(this.count);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterEvent>(_onIncrement);
  }

  Future<void> _onIncrement(
    CounterEvent event,
    Emitter<CounterState> emitter,
  ) async {
    emitter(CounterState(state.count + 1));
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({super.key, required this.index});

  final int index;

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterEvent.increment);
              },
              child: Text('第${widget.index + 1}个计数器的count：${state.count}'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// *************************** setState ********************************

class Counter extends StatefulWidget {
  const Counter({super.key, required this.index});

  final int index;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> with AutomaticKeepAliveClientMixin {
  // 保持状态
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _count++;
            });
          },
          child: Text('第${widget.index + 1}个计数器的count：$_count'),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => _count != 0;
}
