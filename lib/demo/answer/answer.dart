import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/demo/answer/answer_bloc.dart';

void main() {
  runApp(
    const AnswerApp(),
  );
}

class AnswerApp extends StatelessWidget {
  const AnswerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnswerPage(),
    );
  }
}

class AnswerPage extends StatefulWidget {
  const AnswerPage({super.key});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

/// context.read<CounterBloc>().add(CounterEvent.INCREMENT);
///
class _AnswerPageState extends State<AnswerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => AnswerBloc()
          ..add(
            AnswerEventInit(),
          ),
        child: Scaffold(
          body: Stack(
            children: [
              _buildTitle(),
              Positioned(
                top: 10,
                child: _buildTipsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsContent() {
    return BlocBuilder<AnswerBloc, AnswerState>(builder: (context, state) {
      return Column(
        children: List.generate(state.initTextList.length, (index) {
          return Text(
            state.initTextList[index],
          );
        }),
      );
    });
  }

  Widget _buildTitle() {
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        return SizedBox(
          height: 52,
          child: Center(
            child: Text(
              state.title,
              style: const TextStyle(
                color: Color(0xff0a0028),
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
