import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _imageUrls = [
    "https://img.zcool.cn/community/017a9460d52b8311013f4720c83ccf.jpg@1280w_1l_2o_100sh.jpg",
    "https://img.zcool.cn/community/013d9760331be111013ef90f24aa2f.jpg@1280w_1l_2o_100sh.jpg",
    "https://img.zcool.cn/community/0141145ef9b9b4a801215aa00e459e.jpg@2o.jpg",
  ];
  double _appbarAlpha = 0;
  final APPBAR_SCROLL_OFFSET = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                  onNotification: (notify) {
                    // 滚动距离为0的时候，也会出发回调，所以这里做判断
                    // 它会监听所有的滚动，这里还有banner在滚动，所以要过滤出ListView的滚动，第0个元素
                    if (notify is ScrollUpdateNotification && notify.depth == 0) {
                      _onScroll(notify.metrics.pixels);
                    }
                    return true;
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 160,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          pagination: const SwiperPagination(),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 800,
                        child: ListTile(
                          title: Text("111"),
                        ),
                      ),
                    ],
                  ))),
          Opacity(
            opacity: _appbarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appbarAlpha = alpha;
    });
  }
}
