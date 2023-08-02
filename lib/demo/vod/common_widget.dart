import 'package:flutter/material.dart';

/// 列表每一项的标签
Widget buildListItemTag(List<Color> colors, String tag) {
  return DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      gradient: LinearGradient(
        colors: colors,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    ),
  );
}
