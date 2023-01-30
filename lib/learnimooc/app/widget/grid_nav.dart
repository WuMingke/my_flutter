import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

class GridNav extends StatelessWidget {
  const GridNav({Key? key, required this.localNavList}) : super(key: key);

  final List<CommonModel>? localNavList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget? _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList?.map((e) => items.add(_item(context, e))).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: e.url,
            statusBarColor: e.statusBarColor,
            title: e.title,
            hideAppBar: e.hideAppBar,
          );
        }));
      },
      child: Column(
        children: [
          Image.network(
            e.icon,
            width: 32,
            height: 32,
          ),
          Text(
            e.title,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
