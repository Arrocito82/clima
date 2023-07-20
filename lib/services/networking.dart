import 'dart:convert';

import 'package:clima/services/weather.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<Weather> fetch({required String url}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }
}
