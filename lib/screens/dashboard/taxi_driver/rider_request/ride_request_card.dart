import 'package:flutter/material.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/widget/app_color.dart';

class RideRequestCard extends StatelessWidget {
  final TravelModel request;
  final Function(int travelId) onSubmitBid;

  const RideRequestCard({
    super.key,
    required this.request,
    required this.onSubmitBid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Rider name
              Text(
                request.user?.name ?? 'Unknown Rider',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              /// Pickup Address
              _infoRow(Icons.location_on_outlined, "Pickup",
                  request.pickupAddress ?? 'Fetching...', Colors.green),

              const SizedBox(height: 10),

              /// Dropoff Address
              _infoRow(Icons.flag_outlined, "Dropoff",
                  request.destinationAddress ?? 'Fetching...', Colors.red),

              const SizedBox(height: 10),

              /// Phone Number
              _infoRow(Icons.phone_android_outlined, "Phone",
                  request.user?.phone ?? 'N/A', Colors.teal),

              const Divider(height: 28, thickness: 1.2),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(context, Icons.call, "Call", Colors.teal, () {
                    // handle call
                  }),
                  _actionButton(context, Icons.chat, "Text", Colors.orange, () {
                    // handle text
                  }),
                  _actionButton(context, Icons.attach_money_rounded, "Price",
                      AppColor.primaryColor, () {
                    onSubmitBid(request.travelId!);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
