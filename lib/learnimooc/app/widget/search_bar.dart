import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.enabled,
      required this.hideLeft,
      required this.searchBarType,
      required this.hint,
      required this.defaultText,
      required this.leftBtnClick,
      required this.rightBtnClick,
      required this.speakClick,
      required this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftBtnClick;
  final void Function() rightBtnClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String>? onChanged;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch() : _genHomeSearch();
  }

  Widget _genNormalSearch() {
    return Row(
      children: [
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft ?? false
                  ? null
                  : const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: 26,
                    ),
            ),
            widget.leftBtnClick),
        Expanded(
          flex: 1,
          child: _inputBox(),
        ),
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Text(
                "搜索",
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
            ),
            widget.rightBtnClick)
      ],
    );
  }

  Widget _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse("0xffededed"));
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal ? const Color(0xffa9a9a9) : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      // TextField 修改高度同时设置contentPadding时导致垂直不居中
                      // 设置textField有边框，并设置外边框为透明色
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
                      disabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
                      border: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
                      contentPadding: const EdgeInsets.only(left: 5),

                      hintText: widget.hint ?? "",
                      hintStyle: const TextStyle(fontSize: 15),
                    ),
                  )
                : _wrapTap(
                    Text(
                      widget.defaultText ?? "",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    widget.inputBoxClick),
          ),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  Widget _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  Widget _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: [
                    Text(
                      "上海",
                      style: TextStyle(color: _homeFontColor(), fontSize: 14),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor(),
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftBtnClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ),
              widget.rightBtnClick)
        ],
      ),
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;
  }
}
