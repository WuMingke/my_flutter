import 'dart:io';

import 'package:flutter/services.dart';

void changeStatusBarColor(Color color, Brightness brightness) {
  if (Platform.isAndroid) {
    final systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
