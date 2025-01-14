import 'dart:convert';

import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

final apiService = ApiService();
Future<List<Map<String, String>>> getTownships(int cityId) async {
  try {
    final response = await apiService
        .request(AppUrl.getTownship(cityId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);
      final List<Map<String, String>> townships = [];
      for (var township in data) {
        townships.add({
          'id': township['id'].toString(),
          'cityId': township['city_id'].toString(),
          'name': township['name'],
        });
      }
      return townships;
    } else if (response.statusCode == 401) {
      // Handle unauthorized error
      throw Exception(ApiMessages.unauthorized);
    } else if (response.statusCode == 500) {
      // Handle internal server error
      throw Exception(ApiMessages.serverError);
    } else {
      throw Exception(ApiMessages.failedToLoad);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
