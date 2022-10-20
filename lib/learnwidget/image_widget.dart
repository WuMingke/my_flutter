import 'package:flutter/material.dart';

class ImageTest extends StatelessWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage("images/head.jpg"),
          width: 100,
          height: 100,
        ),
        const Text("-------------------------"),
        Image.asset(
          "images/head.jpg",
          width: 100,
          height: 100,
        ),
        const Text("-------------------------"),
        const Image(
          image: NetworkImage(
              "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202107%2F09%2F20210709142454_dc8dc.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668839298&t=947a4098283b87ea6968c7a116810b75"),
          height: 150,
          width: 100,
          color: Colors.blue,
          colorBlendMode: BlendMode.exclusion,
          repeat: ImageRepeat.repeatY,
        ),
        const Text("-------------------------"),
        const Text(
          "\uE03e \uE237 \uE287",
          style: TextStyle(
              fontFamily: "MaterialIcons", fontSize: 20, color: Colors.green),
        ),
        const Text("-------------------------"),
      ],
    );
  }
}
