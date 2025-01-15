import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

var favouriteCuisines = [].obs;
final apiService = ApiService();
Future<void> fetchFavouriteCuisines() async {
  try {
    final response =
        await apiService.request(AppUrl.getFavCuisines, method: "GET");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      favouriteCuisines.value = data;
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    rethrow;
  }
}
