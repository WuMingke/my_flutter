import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/home_model.dart';

const HOME_URL = "https://www.devio.org/io/flutter_app/json/home_page.json";

class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      final result = json.decode(const Utf8Decoder().convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception("Failed to load home_page.json");
    }
  }
}
