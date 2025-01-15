import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final RxList<Map<String,dynamic>> divisions =<Map<String, dynamic>>[].obs;
final apiService = ApiService();
Future<void> getDivisions(int countryId) async {
  try {
    final response = await apiService
        .request(AppUrl.getDivision(countryId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);

      for (var division in data) {
        divisions.add({
          'id': division['id'].toString(),
          'countryId': division['country_id'].toString(),
          'name': division['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
