import 'dart:convert';

import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

final apiService = ApiService();
Future<List<Map<String, String>>> getCities(int divisionId) async {
  try {
    final response =
        await apiService.request(AppUrl.getCities(divisionId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);
      final List<Map<String, String>> cities = [];
      for (var city in data) {
        cities.add({
          'id': city['id'].toString(),
          'divisionId': city['state_id'].toString(),
          'name': city['name'],
        });
      }
      return cities;
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
