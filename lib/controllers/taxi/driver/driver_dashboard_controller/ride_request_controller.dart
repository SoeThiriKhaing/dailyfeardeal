import 'dart:async';

import 'package:dailyfairdeal/controllers/taxi/bid_price/bid_price_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/bid_price/bid_price_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/get_address_from_latlong.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/bid_price/bid_price_service.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideRequestController extends GetxController {
  var isLoading = true.obs;
  var rideRequests = <TravelModel>[].obs;
  var errorMessage = "".obs;
  late int driverId;
  Timer? _timer;

  final travelController = TravelController(
    travelService: TravelService(travelRepository: TravelRepository()),
  );
  final bidPriceController = BidPriceController(
    bidPriceService: BidPriceService(bidPriceRepository: BidPriceRepository()),
  );

  @override
  void onInit() async {
    super.onInit();
    String? taxiDriverId = await getDriverId();
    driverId = int.parse(taxiDriverId!);
    fetchRideRequests();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => fetchRideRequests());
  }

  Future<void> fetchRideRequests() async {
    try {
      isLoading.value = true;
      final requests = await travelController.fetchRiderRequests(driverId);
      for (var request in requests) {
        request.pickupAddress = await getAddressFromLatLng(
            request.pickupLatitude, request.pickupLongitude);
        request.destinationAddress = await getAddressFromLatLng(
            request.destinationLatitude, request.destinationLongitude);
      }
      rideRequests.assignAll(requests);
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitBidPrice(int travelId, double bidPrice) async {
    try {
      bool success = await bidPriceController.submitBidPrice(travelId, driverId, bidPrice);
      SnackbarHelper.showSnackbar(
        title: success ? "Success" : "Error",
        message: success
            ? "Bid price submitted successfully!"
            : "Failed to submit bid price.",
      );
    } catch (e) {
      debugPrint("Bid submission error: $e");
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
