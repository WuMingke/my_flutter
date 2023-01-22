import 'package:flutter/material.dart';

// Widget生命周期
class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({Key? key}) : super(key: key);

  @override
  State<WidgetLifecycle> createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void didUpdateWidget(covariant WidgetLifecycle oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// App生命周期
class AppLifeCycle extends StatefulWidget {
  const AppLifeCycle({Key? key}) : super(key: key);

  @override
  State<AppLifeCycle> createState() => _AppLifeCycleState();
}

// 需要混入WidgetsBindingObserver
class _AppLifeCycleState extends State<AppLifeCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    print("state = $state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
