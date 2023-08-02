import 'package:flutter/material.dart';

class VodNoticeReply extends StatelessWidget {
  const VodNoticeReply({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 300,
        height: 270,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                height: 201,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        height: 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xff8a44ff).withAlpha(80),
                                Colors.white.withAlpha(20),
                              ],
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            "用户昵称",
                            style: TextStyle(
                              color: Color(0xff111111),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                      const Positioned(
                        top: 65,
                        child: Text(
                          "提示语需要替换：请不要走开",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 32,
                        child: SizedBox(
                          height: 36,
                          width: 200,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffdd79ff),
                                  Color(0xff6b60ff),
                                ],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(19)),
                            ),
                            child: Center(
                              child: Text(
                                "好的，等你哦！",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Image.asset(
              // TODO: 2023/8/2 替换头像控件
              "images/head.jpg",
              height: 68,
              width: 68,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
