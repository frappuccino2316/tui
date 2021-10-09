import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animatedStateProvider = ChangeNotifierProvider((ref) => AnimatedState());

class AnimatedState extends ChangeNotifier {
  double radius = 0.0;

  void setRadius(double newRadius) {
    radius = newRadius;
    notifyListeners();
  }
}
