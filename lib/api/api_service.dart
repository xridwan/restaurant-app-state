import 'dart:convert';

import 'package:restaurant_app_state/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getList() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}list'));
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed get data");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
