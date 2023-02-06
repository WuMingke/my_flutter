import 'package:flutter/material.dart';
import 'package:my_flutter/learnimooc/app/model/search_model.dart';
import 'package:my_flutter/learnimooc/app/widget/search_bar.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

import '../../extensions.dart';
import '../dao/search_dao.dart';

const URL = 'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

const TYPES = ['channelgroup', 'gs', 'plane', 'train', 'cruise', 'district', 'food', 'hotel', 'huodong', 'shop', 'sight', 'ticket', 'travelgroup'];

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.hideLeft, this.searchUrl = URL, this.keyWord, this.hint}) : super(key: key);

  final bool? hideLeft;
  final String? searchUrl;
  final String? keyWord;
  final String? hint;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? keyword;
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _appBar(),
          Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: searchModel?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return _item(index);
                },
              )),
        ],
      )),
    );
  }

  Widget _appBar() {
    return Column(
      children: [
        SearchBar(
          enabled: true,
          hideLeft: widget.hideLeft ?? true,
          searchBarType: SearchBarType.normal,
          hint: widget.hint ?? "网红打卡地 景点 酒店 美食",
          leftBtnClick: () {
            changeStatusBarColor(Colors.transparent, Brightness.light);
            Navigator.pop(context);
          },
          rightBtnClick: () {},
          speakClick: () {},
          inputBoxClick: () {},
          onChanged: _onChanged,
          defaultText: widget.keyWord ?? "",
        ),
      ],
    );
  }

  Widget? _item(int index) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem? item = searchModel?.data?[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: item?.url ?? "",
            statusBarColor: "",
            title: "详情",
            hideAppBar: true,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item?.type)),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 300,
                  child: _subTitle(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget? _title(SearchItem? item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel?.keyword));
    spans.add(TextSpan(text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}', style: const TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String? word, String? keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty || keyword == null || keyword.isEmpty) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = const TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(text: word.substring(preIndex, preIndex + keyword.length), style: keywordStyle));
      }
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }

  Widget? _subTitle(SearchItem? item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item?.price ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ${item?.star ?? ''}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }

  String _typeImage(String? type) {
    String path = "lib/learnimooc/app/images/type_travelgroup.png";
    if (type == null) {
      return path;
    }

    for (final val in TYPES) {
      if (type.contains(val)) {
        path = "lib/learnimooc/app/images/type_$val.png";
        break;
      }
    }
    return path;
  }

  _onChanged(String text) {
    keyword = text;
    if (keyword?.isEmpty ?? true) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = "${widget.searchUrl}$keyword";
    SearchDao.fetch(url, keyword).then((value) {
      // TODO: 2023/2/6 mingKE 这里实时请求，其实需要优化
      setState(() {
        searchModel = value;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
