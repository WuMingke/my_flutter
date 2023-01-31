import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key, required this.child, required this.isLoading, required this.cover}) : super(key: key);

  final Widget child; // 主界面
  final bool isLoading; // 判断显示主界面还是显示进度
  final bool cover; // 是否放在页面之上

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading
            ? child
            : _loadingView
        : Stack(
            children: [child, isLoading ? _loadingView : Stack()],
          );

    /**
     * 三元运算符
     *
     * 首先如果isCover是false的情况下也就是非叠加的效果，那么接下来又分两种情况：

        isLoading = true 显示_loadView；

        isLoading = false 显示child；

        首先如果isCover是true的情况下也就是叠加的效果，那么接下来又分两种情况：

        isLoading = true 显示child和_loadView；

        isLoading = false 只显示child；
     */
  }

  Widget get _loadingView {
    // 理解为计算属性，_loadingView是返回的结果
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
