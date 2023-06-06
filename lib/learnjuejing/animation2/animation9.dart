import 'package:flutter/material.dart';

class Animation9 extends StatefulWidget {
  const Animation9({super.key});

  @override
  State<Animation9> createState() => _Animation9State();
}

class _Animation9State extends State<Animation9> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildBtn(Icons.remove, Colors.red, _doMinus),
          SizedBox(
            width: 80,
            child: _buildAnimatedSwitcher(context),
          ),
          _buildBtn(Icons.add, Colors.blue, _doAdd),
        ],
      ),
    );
  }

  Widget _buildAnimatedSwitcher(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 20),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Text(
        '$_count',
        key: UniqueKey(),
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _buildBtn(IconData icon, Color color, VoidCallback onPressed) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      textColor: const Color(0xffffffff),
      elevation: 3,
      color: color,
      highlightColor: const Color(0xfff88b0a),
      splashColor: Colors.red,
      shape: const CircleBorder(
        side: BorderSide(
          width: 2,
          color: Color(0xFFDFDFDF),
        ),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  void _doMinus() {
    setState(() {
      _count -= 1;
    });
  }

  void _doAdd() {
    setState(() {
      _count += 1;
    });
  }
}
