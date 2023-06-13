import 'package:flutter/material.dart';

/// 自定义 Notification
class MyNotification extends Notification {
  final dynamic data;
  MyNotification(this.data);
}

class MyNotificationWidget extends StatelessWidget {
  const MyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is MyNotification) {
          print("通知：${notification.data}");
          return true;
        }
        return false;
      },
      child: const Sender(),
    );
  }
}

class Sender extends StatelessWidget {
  const Sender({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        ElevatedButton(
          onPressed: () {
            MyNotification('string data...').dispatch(context);
          },
          child: const Text('发送字符串通知'),
        ),
        ElevatedButton(
          onPressed: () {
            MyNotification(Colors.amber).dispatch(context);
          },
          child: const Text('发送颜色通知'),
        ),
      ],
    );
  }
}
