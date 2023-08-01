// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
//

import 'package:flutter/material.dart';

/// 有报错，暂时用这个代替
class WebView extends StatefulWidget {
  const WebView({Key? key, this.url = "", required this.statusBarColor, this.title = "", this.hideAppBar = false, this.backForbid = false})
      : super(key: key);

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class WebView extends StatefulWidget {
//   const WebView({Key? key, this.url = "", required this.statusBarColor, this.title = "", this.hideAppBar = false, this.backForbid = false})
//       : super(key: key);
//
//   final String url;
//   final String statusBarColor;
//   final String title;
//   final bool hideAppBar;
//   final bool backForbid;
//
//   @override
//   State<WebView> createState() => _WebViewState();
// }
//
// class _WebViewState extends State<WebView> {
//   final webViewRef = FlutterWebviewPlugin();
//   StreamSubscription<String>? _onUrlChanged;
//   StreamSubscription<WebViewStateChanged>? _onStateChanged;
//   StreamSubscription<WebViewHttpError>? _onHttpError;
//   bool exiting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     webViewRef.close();
//     _onUrlChanged = webViewRef.onUrlChanged.listen((event) {});
//
//     _onStateChanged = webViewRef.onStateChanged.listen((event) {
//       switch (event.type) {
//         case WebViewState.shouldStart:
//           //防止返回时携程H5页面重定向到打开携程自己的上一级网址
//           if (_isToMain(event.url) && !exiting) {
//             if (widget.backForbid) {
//               webViewRef.launch(event.url);
//             } else {
//               Navigator.pop(context);
//               exiting = true;
//             }
//           }
//           break;
//         case WebViewState.startLoad:
//           break;
//         case WebViewState.finishLoad:
//           break;
//         case WebViewState.abortLoad:
//           break;
//       }
//     });
//
//     _onHttpError = webViewRef.onHttpError.listen((event) {});
//   }
//
//   _isToMain(String? url) {
//     bool contain = false;
//     for (final value in CATCH_URLS) {
//       if (url?.endsWith(value) ?? false) {
//         contain = true;
//         break;
//       }
//     }
//     return contain;
//   }
//
//   @override
//   void dispose() {
//     _onUrlChanged?.cancel();
//     _onStateChanged?.cancel();
//     _onHttpError?.cancel();
//     webViewRef.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color backButtonColor = widget.statusBarColor == "ffffff" ? Colors.white : Colors.black;
//
//     return Scaffold(
//       body: Column(
//         children: [
//           _appBar(Color(int.parse("0xff${widget.statusBarColor ?? "ffffff"}")), backButtonColor), // statusBarColor 是接口数据，为null，
//           Expanded(
//             child: WebviewScaffold(
//               url: widget.url,
//               withLocalStorage: true,
//               hidden: true,
//               withZoom: true,
//               initialChild: Container(
//                 color: Colors.white,
//                 child: const Center(
//                   child: Text("loading..."),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _appBar(Color backgroundColor, Color backButtonColor) {
//     if (widget.hideAppBar ?? true) {
//       return Container(
//         color: backgroundColor,
//         height: 30,
//       );
//     } else {
//       return Container(
//         color: backButtonColor,
//         padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
//         child: FractionallySizedBox(
//           child: Stack(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   child: Icon(
//                     Icons.close,
//                     color: backButtonColor,
//                     size: 26,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Text(
//                     widget.title,
//                     style: TextStyle(color: backButtonColor, fontSize: 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }
