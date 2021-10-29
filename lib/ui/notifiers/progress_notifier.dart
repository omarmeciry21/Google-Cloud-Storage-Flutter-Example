import 'package:flutter/material.dart';

class ProgressNotifier with ChangeNotifier {
// Initial value
  var _progress = 0.0;
  double get progress => _progress;
  void start({required String url, required String filename}) async {
// download logic...
  }
  void resetProgress() {
    if (progress != 0) {
      _progress = 0;
      notifyListeners();
    }
  }

  void updateProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
