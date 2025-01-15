import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final apiService = ApiService();
final RxList<Map<String,dynamic>> cities =<Map<String, dynamic>>[].obs;
Future<void> getCities(int divisionId) async {
  try {
    final response = await apiService
        .request(AppUrl.getCities(divisionId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);

      for (var city in data) {
        cities.add({
          'id': city['id'].toString(),
          'divisionId': city['state_id'].toString(),
          'name': city['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
