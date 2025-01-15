import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';
final RxList<Map<String,dynamic>> wards =<Map<String, dynamic>>[].obs;
final apiService = ApiService();

Future<void> getWards(int townshipId) async {
  try {
    final response = await apiService
        .request(AppUrl.getWard(townshipId.toString()), method: "GET");

    if (response.statusCode == 200) {
      // Parse the response body into a list of countries
      final data = json.decode(response.body);
      for (var ward in data) {
        wards.add({
          'id': ward['id'].toString(),
          'townshipId': ward['township_id'].toString(),
          'name': ward['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
