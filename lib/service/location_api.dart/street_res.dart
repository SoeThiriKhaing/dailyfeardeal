import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';
final RxList<Map<String,dynamic>> streets=<Map<String, dynamic>>[].obs;
final apiService = ApiService();
Future<void> getStreets(int wardId) async {
  try {
    final response = await apiService
        .request(AppUrl.getStreet(wardId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);
     
      for (var street in data) {
        streets.add({
          'id': street['id'].toString(),
          'wardId': street['ward_id'].toString(),
          'name': street['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
