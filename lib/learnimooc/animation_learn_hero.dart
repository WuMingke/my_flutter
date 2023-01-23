import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

/// 标准的 hero动画
class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero(this.photo, this.onTap, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  final url = "https://lmg.jj20.com/up/allimg/1114/040221103339/210402103339-8-1200.jpg";

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return PhotoHero(url, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Flippers Page"),
          ),
          body: Container(
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topLeft,
            child: PhotoHero(url, () {
              Navigator.of(context).pop();
            }, 100),
          ),
        );
      }));
    }, 300.0);
  }
}
