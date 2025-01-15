import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';
final RxList<Map<String,dynamic>> townships =<Map<String, dynamic>>[].obs;
final apiService = ApiService();
Future<void> getTownships(int cityId) async {
  try {
    final response = await apiService
        .request(AppUrl.getTownship(cityId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);
    
      for (var township in data) {
        townships.add({
          'id': township['id'].toString(),
          'cityId': township['city_id'].toString(),
          'name': township['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
