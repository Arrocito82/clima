import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<Map<String, dynamic>?> fetch({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw 'Invalid API key';
      } else {
        throw 'Failed to load weather';
      }
    } on SocketException {
      throw 'No internet connexion';
    }
  }
}
