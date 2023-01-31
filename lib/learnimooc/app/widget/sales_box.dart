import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/model/sales_box_model.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

class SalesBox extends StatelessWidget {
  const SalesBox({Key? key, this.salesBox}) : super(key: key);

  final SalesBoxModel? salesBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  Widget? _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context, salesBox?.bigCard1, salesBox?.bigCard2, true, false));
    items.add(_doubleItem(context, salesBox?.smallCard1, salesBox?.smallCard2, false, false));
    items.add(_doubleItem(context, salesBox?.smallCard3, salesBox?.smallCard4, false, true));
    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0xfff2f2f2),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox?.icon ?? "",
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return WebView(
                        url: salesBox?.moreUrl ?? "",
                        statusBarColor: "",
                        title: "more activity",
                        hideAppBar: true,
                      );
                    }));
                  },
                  child: const Text(
                    "获取更多福利 > ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel? left, CommonModel? right, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, left, big, true, last),
        _item(context, right, big, false, last),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel? e, bool big, bool left, bool last) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: e?.url ?? "",
            statusBarColor: "",
            title: "",
            hideAppBar: true,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? BorderSide.none : borderSide,
          ),
        ),
        child: Image.network(
          e?.icon ?? "",
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: big ? 129 : 80,
        ),
      ),
    );
  }
}
