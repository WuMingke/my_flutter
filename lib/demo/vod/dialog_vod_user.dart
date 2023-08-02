import 'package:flutter/material.dart';
import 'package:my_flutter/demo/vod/common_widget.dart';
import 'package:my_flutter/demo/vod/data.dart';

/// 普通用户视角
class VodUserDialog extends StatelessWidget {
  const VodUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 552,
      decoration: const BoxDecoration(
        color: Color(0xff211e27),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildUserDialogTitle(1),
          _buildUserDialogList(context),
        ],
      ),
    );
  }

  /// 标题
  /// type 0-房主，1-主持人
  Widget _buildUserDialogTitle(int type) {
    String role = type == 0 ? "房主" : "主持人";
    return SizedBox(
      height: 61,
      child: Center(
        child: Text(
          "$role的节目单",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 列表
  Widget _buildUserDialogList(BuildContext context) {
    List<ProgramInfo> data = VodData().tempData();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 356,
        maxWidth: MediaQuery.of(context).size.width - 24,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff432c84),
            ),
            height: 98,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: _buildUserDialogListItem(data[index]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: data.length,
      ),
    );
  }

  /// 列表项目
  Widget _buildUserDialogListItem(ProgramInfo data) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildListItemTag(
                      [const Color(0xffdd79ff), const Color(0xff6b60ff)],
                      data.tags1,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    buildListItemTag(
                      [const Color(0xffffc2c2), const Color(0xffeb50bf)],
                      data.tags2,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 7),
              child: Column(
                children: [
                  Image.network(
                    data.giftUrl,
                    width: 36,
                    height: 36,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/ic_gold_coin.png",
                        width: 14,
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          data.giftPrice,
                          style: const TextStyle(
                            color: Color(0xfffeba15),
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Divider(
            height: 0.5,
            color: Color(0xff6041b6),
          ),
        ),
        Row(
          children: [
            Text(
              "点播数:${data.buyNum}",
              style: const TextStyle(
                color: Color(0x66ffffff),
                fontSize: 12,
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: 60,
              height: 20,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7a80ff),
                ),
                child: const Center(
                  child: Text(
                    "送礼点播",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
