import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter/demo/vod/dialog_edit_program.dart';
import 'package:my_flutter/demo/vod/dialog_vod_notice_reply.dart';
import 'package:my_flutter/demo/vod/dialog_vod_program_owner.dart';
import 'package:my_flutter/demo/vod/dialog_vod_user.dart';

void main() {
  runApp(
    const VodApp(),
  );
}

class VodApp extends StatelessWidget {
  const VodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VodHome(),
    );
  }
}

class VodHome extends StatefulWidget {
  const VodHome({super.key});

  @override
  State<VodHome> createState() => _VodHomeState();
}

class _VodHomeState extends State<VodHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _btnBottom("普通用户 点播", const VodUserDialog()),
            _btnBottom("房主、技能者 点播", const DialogProgramOwner()),
            _btnCenter("添加、编辑节目", const EditProgramDialog()),
            _btnCenter("点播回应", const VodNoticeReply()),
          ],
        ),
      ),
    );
  }

  Widget _btnCenter(String title, Widget to) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return to;
          },
          // barrierColor: Colors.transparent,
        );
      },
      child: _btnContent(title),
    );
  }

  Widget _btnBottom(String title, Widget to) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return to;
          },
          barrierColor: Colors.transparent,
          enableDrag: false,
        );
      },
      child: _btnContent(title),
    );
  }

  Widget _btnContent(String title) {
    return ColoredBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: SizedBox(
        width: 200,
        height: 100,
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
