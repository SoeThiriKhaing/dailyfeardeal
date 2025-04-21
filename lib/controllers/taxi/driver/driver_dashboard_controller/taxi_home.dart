import 'dart:async';
import 'package:dailyfairdeal/util/timer_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TaxiHomeController extends ChangeNotifier {
  late TimerManager timerManager;
  Timer? searchTimer;
  bool isSearching = false;

  void init() {
    timerManager = TimerManager();
  }

  void startSearch() {
    if (isSearching) return;
    isSearching = true;
    searchTimer = timerManager.startPeriodicSearch(_performSearch);
    notifyListeners();
  }

  void stopSearch() {
    if (!isSearching) return;
    isSearching = false;
    timerManager.stopTimer(searchTimer);
    notifyListeners();
  }

  void _performSearch() {
    // Perform the periodic search here
    print("Searching...");
  }

  Marker createDriverMarker(String id, LatLng location, String driverName) {
    return createDriverMarker(id, location, driverName);
  }
}
