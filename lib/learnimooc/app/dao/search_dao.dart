import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_flutter/learnimooc/app/model/search_model.dart';

class SearchDao {
  static Future<SearchModel> fetch(String url, String? keyword) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(const Utf8Decoder().convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    } else {
      throw Exception("Failed to load home_page.json");
    }
  }
}
