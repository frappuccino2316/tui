import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animatedStateProvider = ChangeNotifierProvider((ref) => AnimatedState());

class AnimatedState extends ChangeNotifier {
  int radius = 0;

  void setRadius(int newRadius) {
    radius = newRadius;
    notifyListeners();
  }
}
