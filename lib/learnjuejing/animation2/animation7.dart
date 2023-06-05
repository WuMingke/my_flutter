// import 'dart:math';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
//
// class Animation7 extends StatelessWidget {
//   const Animation7({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircleHalo(),
//     );
//   }
// }
//
// class CircleHalo extends StatefulWidget {
//   const CircleHalo({super.key});
//
//   @override
//   State<CircleHalo> createState() => _CircleHaloState();
// }
//
// class _CircleHaloState extends State<CircleHalo> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _controller.repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: const Size(200, 200),
//       painter: CircleHaloPainter(_controller),
//     );
//   }
// }
//
// class CircleHaloPainter extends CustomPainter {
//   late Paint mPaint;
//   late Path mPath;
//   late Path mCirclePath;
//   final Animation<double> animation;
//
//   CircleHaloPainter(this.animation) : super(repaint: animation) {
//     final Animatable<double> breathTween = TweenSequence<double>(
//       <TweenSequenceItem<double>>[
//         TweenSequenceItem<double>(
//           weight: 1,
//           tween: Tween<double>(begin: 0, end: 10),
//         ),
//         TweenSequenceItem<double>(
//           weight: 1,
//           tween: Tween<double>(begin: 10, end: 0),
//         ),
//       ],
//     ).chain(
//       CurveTween(curve: Curves.decelerate),
//     );
//     final colors = [
//       const Color(0xFFF60C0C),
//       const Color(0xFFF3B913),
//       const Color(0xFFE7F716),
//       const Color(0xFF3DF30B),
//       const Color(0xFF0DF6EF),
//       const Color(0xFF0829FB),
//       const Color(0xFFB709F4),
//     ];
//     final List<double> pos = List.generate(colors.length, (index) => index / colors.length);
//     // colors.addAll(colors.reversed.toList());
//     mPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..maskFilter = MaskFilter.blur(BlurStyle.solid, breathTween.evaluate(animation))
//       ..shader = ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi)
//       ..strokeWidth = 1;
//     mCirclePath = Path()
//       ..addOval(Rect.fromCenter(
//         center: Offset.zero,
//         width: 100,
//         height: 100,
//       ));
//
//     final circlePath2 = Path()
//       ..addOval(Rect.fromCenter(
//         center: const Offset(-1, 0),
//         width: 100,
//         height: 100,
//       ));
//     mPath = Path.combine(PathOperation.difference, mCirclePath, circlePath2);
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.translate(size.width / 2, size.height / 2);
//     canvas.drawPath(mCirclePath, mPaint);
//
//     canvas.save();
//     canvas.rotate(animation.value * 2 * pi);
//     canvas.drawPath(mPath, mPaint);
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(covariant CircleHaloPainter oldDelegate) {
//     return true;
//   }
// }
