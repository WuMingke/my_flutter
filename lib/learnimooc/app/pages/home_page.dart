import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter/learnimooc/app/dao/home_dao.dart';
import 'package:my_flutter/learnimooc/app/model/common_model.dart';
import 'package:my_flutter/learnimooc/app/model/grid_nav_model.dart';
import 'package:my_flutter/learnimooc/app/model/home_model.dart';
import 'package:my_flutter/learnimooc/app/model/sales_box_model.dart';
import 'package:my_flutter/learnimooc/app/widget/grid_nav.dart';
import 'package:my_flutter/learnimooc/app/widget/grid_nav_center.dart';
import 'package:my_flutter/learnimooc/app/widget/loading_container.dart';
import 'package:my_flutter/learnimooc/app/widget/sales_box.dart';
import 'package:my_flutter/learnimooc/app/widget/sub_nav.dart';
import 'package:my_flutter/learnimooc/app/widget/web_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appbarAlpha = 0;
  final APPBAR_SCROLL_OFFSET = 100;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel? gridNavModel;
  SalesBoxModel? salesBox;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _isLoading,
        cover: false,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _loadData2,
                child: NotificationListener(
                    onNotification: (notify) {
                      // 滚动距离为0的时候，也会出发回调，所以这里做判断
                      // 它会监听所有的滚动，这里还有banner在滚动，所以要过滤出ListView的滚动，第0个元素
                      if (notify is ScrollUpdateNotification && notify.depth == 0) {
                        _onScroll(notify.metrics.pixels);
                        return true;
                      }
                      return false; // TODO: 2023/1/31 mingKE 这里的返回值会影响RefreshIndicator的手势监听
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 160,
                          child: Swiper(
                            itemCount: bannerList.length,
                            autoplay: true,
                            pagination: const SwiperPagination(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return WebView(
                                      url: bannerList[index].url,
                                      statusBarColor: bannerList[index].statusBarColor,
                                      title: bannerList[index].title,
                                      hideAppBar: bannerList[index].hideAppBar,
                                    );
                                  }));
                                },
                                child: Image.network(
                                  bannerList.isEmpty ? "" : bannerList[index].icon,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: GridNav(localNavList: localNavList),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: GridNavCenter(
                            gridNavModel: gridNavModel,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SubNav(subNavList: subNavList),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SalesBox(salesBox: salesBox),
                        ),
                      ],
                    )),
              ),
            ),
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

  // 第一种方式
  void _loadData() {
    HomeDao.fetch().then((result) {
      setState(() {
        localNavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavList = result.subNavList;
        salesBox = result.salesBox;
        _isLoading = false;
        bannerList = result.bannerList;
      });
    }).onError((error, stackTrace) {
      // setState(() {
      //   // resultString = error.toString();
      // });
      _isLoading = false;
      showAboutDialog(context: context, applicationName: error.toString());
    });
  }

  // 第二种方式
  Future<void> _loadData2() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      setState(() {
        // resultString = homeModel.config.searchUrl; //这里就需要分别去取了
        showAboutDialog(context: context, applicationName: "req success!!");
      });
    } catch (e) {
      setState(() {
        // resultString = e.toString();
      });
    }
  }
}
