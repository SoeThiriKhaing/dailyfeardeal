import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createDriverMarker(String id, LatLng location, String driverName) {
  return Marker(
    markerId: MarkerId("driver_$id"),
    position: location,
    infoWindow: InfoWindow(title: "Driver: $driverName Location"),
  );
}
