import 'package:flutter/material.dart';

/// 添加、编辑 节目
class EditProgramDialog extends StatelessWidget {
  const EditProgramDialog({super.key});

  final int type = 1; // 0-添加，1-编辑
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      shadowColor: Colors.transparent,
      child: SizedBox(
        width: 300,
        height: 432,
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff8a44ff).withAlpha(80),
                      Colors.white.withAlpha(20),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                    child: Text(
                  type == 0 ? "添加节目" : "编辑节目",
                  style: const TextStyle(
                    color: Color(0xff111111),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '节目名称(0/20)',
                    style: _commonTextStyle(),
                  ),
                  const TextField(),
                  Text(
                    '节目类型(1/2)',
                    style: _commonTextStyle(),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 24),
                    child: ListView(),
                  ),
                  Text(
                    '点播费用',
                    style: _commonTextStyle(),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: ListView(),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('==============取消');
                        },
                        child: SizedBox(
                          width: 120,
                          height: 36,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xfff5f5f5), Color(0xfff5f5f5)]),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: const Center(
                              child: Text(
                                "取消",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          print('==============确定');
                        },
                        child: SizedBox(
                          width: 120,
                          height: 36,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xffdd79ff), Color(0xff6b60ff)]),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: const Center(
                              child: Text(
                                "确定",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _commonTextStyle() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff3e3e3e));
  }
}
