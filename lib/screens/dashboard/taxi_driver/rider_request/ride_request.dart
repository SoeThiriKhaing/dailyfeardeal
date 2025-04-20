import 'package:dailyfairdeal/controllers/taxi/driver/driver_dashboard_controller/ride_request_controller.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request/build_price_dialog.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request/ride_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideRequest extends StatelessWidget {
  final rideRequestController = Get.put(RideRequestController());

   RideRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (rideRequestController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (rideRequestController.errorMessage.isNotEmpty) {
        return Center(child: Text(rideRequestController.errorMessage.value));
      }
      if (rideRequestController.rideRequests.isEmpty) {
        return const Center(child: Text('No Rider Request'));
      }
      return ListView.builder(
        itemCount: rideRequestController.rideRequests.length,
        itemBuilder: (context, index) {
          final request = rideRequestController.rideRequests[index];
          return RideRequestCard(
            request: request,
            onSubmitBid: (travelId) => showBidPriceDialog(
              context: context,
              onSubmit: (bidPrice) =>
                  rideRequestController.submitBidPrice(travelId, bidPrice),
              travelId: travelId,
            ),
          );
        },
      );
    });
  }
}
