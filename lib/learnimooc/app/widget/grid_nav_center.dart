import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/model/grid_nav_model.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

class GridNavCenter extends StatelessWidget {
  const GridNavCenter({Key? key, this.gridNavModel}) : super(key: key);

  final GridNavModel? gridNavModel;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      // 设置圆角
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    var hotel = gridNavModel?.hotel;
    if (hotel != null) {
      items.add(_gridNavItem(context, hotel, true));
    }
    var flight = gridNavModel?.flight;
    if (flight != null) {
      items.add(_gridNavItem(context, flight, false));
    }
    var travel = gridNavModel?.travel;
    if (travel != null) {
      items.add(_gridNavItem(context, travel, false));
    }
    return items;
  }

  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    for (var element in items) {
      expandItems.add(Expanded(
        flex: 1,
        child: element,
      ));
    }
    Color startColor = Color(int.parse("0xff${gridNavItem.startColor}"));
    Color endColor = Color(int.parse("0xff${gridNavItem.endColor}"));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel top, CommonModel bottom) {
    return Column(
      children: [
        Expanded(
          child: _item(context, top, true),
        ),
        Expanded(
          child: _item(context, bottom, false),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: first ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
          context,
          Center(
            child: Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          model,
        ),
      ),
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            title: model.title,
            hideAppBar: model.hideAppBar,
          );
        }));
      },
      child: widget,
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
      context,
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
      model,
    );
  }
}
