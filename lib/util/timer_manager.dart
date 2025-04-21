import 'dart:async';

class TimerManager {
  Timer? startPeriodicSearch(Function callback) {
    return Timer.periodic(Duration(seconds: 2), (_) => callback());
  }

  void stopTimer(Timer? timer) {
    timer?.cancel();
  }
}
