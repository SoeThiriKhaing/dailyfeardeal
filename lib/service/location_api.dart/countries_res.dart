import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final RxList<Map<String, dynamic>> countries = <Map<String, dynamic>>[].obs;
final apiService = ApiService();
Future<void> getCountries() async {
  try {
    final response = await apiService.request(AppUrl.getCountry, method: "GET");
    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);

      for (var country in data['data']) {
        countries.add({
          'id': country['id'].toString(),
          'name': country['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
