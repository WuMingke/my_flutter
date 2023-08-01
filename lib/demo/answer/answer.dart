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
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffd1b1ff), Color(0x00d9b1ff)],
        ),
      ),
      child: BlocBuilder<AnswerBloc, AnswerState>(
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: 250,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 0.8],
                      colors: [
                        Color(0xff6cb6ff),
                        Color(0x00d1b1ff),
                      ],
                    ),
                  ),
                ),
              ),
              _imageIcon(
                top: 25,
                left: 25,
                right: null,
                height: 144,
                width: 144,
                icon: "images/xnlr_cwzbsq_icon_bg.png",
              ),
              Column(
                children: [
                  _buildTitle(),
                  if (state.mCurrentState == 0) ...{
                    _buildTipsContent(),
                  } else ...{
                    _buildQuestion(),
                  },
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  _buildConfirmBtn(),
                ],
              ),
              if (state.mCurrentState != 0) ...{
                _imageIcon(
                  top: 42,
                  left: null,
                  right: 10,
                  height: 170,
                  width: 170,
                  icon: "images/xnlr_cwzbsq_icon_zb.png",
                )
              }
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestion() {
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(
            top: 100,
            left: 12,
            right: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "答题进度${state.mCurrentState}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8670ff),
                      ),
                    ),
                    const Text(
                      "/3",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color(0xff999999),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width - 64,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0x99666eff),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: state.mCurrentState < 3 ? state.mCurrentState * 0.3 : 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffd9b1ff),
                            Color(0xff6cb6ff),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  state.q[state.mCurrentState - 1].title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200), // Stack 没有对 ListView 约束
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<AnswerBloc>().add(
                                AnswerEventSelect(index),
                              );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: state.select[state.mCurrentState] == index
                                  ? [
                                      const Color(0xff8670ff),
                                      const Color(0xff8670ff),
                                    ]
                                  : [
                                      const Color(0x1a6cb6ff),
                                      const Color(0x1ad9b1ff),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 16,
                              right: 15,
                              bottom: 16,
                            ),
                            child: Text(
                              "${String.fromCharCode(index + 65)} ${state.q[state.mCurrentState - 1].answer[index]}",
                              style: TextStyle(
                                // 对应页面选择的题号等于index
                                color: state.select[state.mCurrentState] == index ? Colors.white : const Color(0xff666666),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: state.q[state.mCurrentState - 1].answer.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _imageIcon({
    required double? top,
    required double? left,
    required double? right,
    required double height,
    required double width,
    required String icon,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: SizedBox(
        height: height,
        width: width,
        child: Image(
          image: AssetImage(icon),
        ),
      ),
    );
  }

  Widget _buildConfirmBtn() {
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: GestureDetector(
            onTap: () {
              if (state.select[state.mCurrentState] == -1) {
                print("=============需要选择答案，才能进入下一题");
              } else if (state.mCurrentState == 3) {
                print("=============去判断是否答对，然后调接口");
              } else {
                context.read<AnswerBloc>().add(AnswerEventNext());
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: state.select[state.mCurrentState] == -1
                      ? [
                          const Color(0xffeeeeee),
                          const Color(0xffeeeeee),
                        ]
                      : [
                          const Color(0xff6cb6ff),
                          const Color(0xffd9b1ff),
                        ],
                ),
              ),
              height: 44,
              width: 240,
              child: Center(
                child: Text(
                  state.btnContent,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: state.select[state.mCurrentState] == -1 ? const Color(0xffcccccc) : Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTipsContent() {
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 22,
              right: 22,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Text(
                  state.initTextList[index],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: state.initTextList.length,
            ),
          ),
        );
      },
    );
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
                fontSize: 18,
                color: Color(0xff111111),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
