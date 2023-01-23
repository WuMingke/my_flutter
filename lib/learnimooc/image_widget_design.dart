import 'package:flutter/material.dart';

///
/// Image
/// Image.asset
/// Image.network
/// Image.file
/// Image.memory  用于从Unit8List获取图像
///
/// 在加载项目中的图片资源时，为了让Image能够根据像素密度自动适配不同分辨率的图片，
/// 应该使用AssetImage指定图像，并确保在widget树中的"Image"widget上存在MaterialApp，
/// WidgetsApp或MediaQuery窗口widget
///
/// path_provider 插件 获取相对路径
///
/// 设置placeholder：需要使用 FadeInImage,他可以从内存、本地资源中加载placeholder
/// 从内存中加载placeholder：需要 transparent_image 插件
///
/// 配置图片缓存：cached_network_image 插件
class ImageWidgetDesign extends StatefulWidget {
  const ImageWidgetDesign({Key? key}) : super(key: key);

  @override
  State<ImageWidgetDesign> createState() => _ImageWidgetDesignState();
}

class _ImageWidgetDesignState extends State<ImageWidgetDesign> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
