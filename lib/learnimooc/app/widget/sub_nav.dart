import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

class SubNav extends StatelessWidget {
  const SubNav({Key? key, this.subNavList}) : super(key: key);

  final List<CommonModel>? subNavList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget? _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList?.map((e) => items.add(_item(context, e))).toList();
    // 计算出第一行的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList!.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel e) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
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
                width: 18,
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  e.title,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
