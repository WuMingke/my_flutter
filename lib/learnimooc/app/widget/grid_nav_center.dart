import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/grid_nav_model.dart';

class GridNavCenter extends StatelessWidget {
  const GridNavCenter({Key? key, this.gridNavModel}) : super(key: key);

  final GridNavModel? gridNavModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel?.hotel != null) {}
    if (gridNavModel?.flight != null) {}
    if (gridNavModel?.travel != null) {}
    return items;
  }
}
