import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animatedStateProvider = ChangeNotifierProvider((ref) => AnimatedState());

class AnimatedState extends ChangeNotifier {
  double radian = 0.0;
  double p = 1;
  double position = 0;

  void setRadian(double newRadian) {
    radian = newRadian;
    notifyListeners();
  }

  void setP(double newP) {
    p = newP;
    notifyListeners();
  }

  void setPosition(double newPosition) {
    position = newPosition;
    notifyListeners();
  }
}
