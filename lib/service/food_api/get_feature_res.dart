import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final apiService = ApiService();
var featuredRestaurants = [].obs;
Future<void> getFeatureRestaurants() async {
  try {
    final response = await apiService.request(AppUrl.getFeatRestaurant);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> dataList = decodedResponse['data'];

      featuredRestaurants.value = dataList;
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    rethrow;
  }
}
