import 'dart:async';
import 'package:flutter/material.dart';

class CronometroModel extends ChangeNotifier {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  Duration get elapsedTime => _elapsedTime;

  void startTimer() {
    _stopwatch.start();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _elapsedTime = _stopwatch.elapsed;
      notifyListeners();
    });
  }

  void stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    }
  }

  void resetTimer() {
    _stopwatch.reset();
    _elapsedTime = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
