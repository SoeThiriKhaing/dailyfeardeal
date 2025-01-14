import 'dart:convert';

import 'package:dailyfairdeal/widget/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeatureresApi extends GetxController{
 var featuredRestaurants = [].obs; // Observable for storing fetched data
  var filteredCategories = [].obs; // Observable for filtered data
  Future<void> fetchFeaturedRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/feature-restaurants"),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        featuredRestaurants.value = data['data'];
        filteredCategories.value = featuredRestaurants; // Initialize with all data
      } else if (response.statusCode == 401) {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Unauthorized access.",
          backgroundColor: Colors.red,
        );
      } else {
         SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Failed to load data.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(
          title: "Error",
          message: "An error occurred: $e",
          backgroundColor: Colors.red,
        );
    }
  }

  void updateSearchQuery(String query) {
    filteredCategories.value = featuredRestaurants
        .where((restaurant) =>
            restaurant['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

}
