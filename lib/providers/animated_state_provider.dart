import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animatedStateProvider = ChangeNotifierProvider((ref) => AnimatedState());

class AnimatedState extends ChangeNotifier {
  double radian = 0.0;
  double p = 1;
  double horizonPosition = 0.0;
  double verticalPosition = 0.0;
  bool displayImage = false;
  double imageOpasity = 0.0;

  double getRadianByIndex(int index) {
    if (index == 0) {
      return radian * 0.75;
    }
    return radian * index;
  }

  void setRadian(double newRadian) {
    radian = newRadian;
    notifyListeners();
  }

  void setP(double newP) {
    p = newP;
    notifyListeners();
  }

  double getHorizonPositionByIndex(int index) {
    if (index == 0) {
      return horizonPosition * 4;
    }
    if (index % 3 == 0) {
      return horizonPosition * index * -1;
    } else {
      return horizonPosition * index;
    }
  }

  void setHorizonPosition(double newHorizonPosition) {
    horizonPosition = newHorizonPosition;
    notifyListeners();
  }

  double getVerticalPositionByIndex(int index) {
    if (index == 0) {
      return verticalPosition * 4;
    }
    if (index % 2 == 0) {
      return verticalPosition * index;
    } else {
      return verticalPosition * index * -1;
    }
  }

  void setVerticalPosition(double newVerticalPosition) {
    verticalPosition = newVerticalPosition;
    notifyListeners();
  }

  void changeDisplayImage() {
    displayImage = !displayImage;
    notifyListeners();
  }

  void setImageOpacity(double opasity) {
    imageOpasity = opasity;
    notifyListeners();
  }

  void resetAnimatedState() {
    radian = 0.0;
    p = 1;
    horizonPosition = 0.0;
    verticalPosition = 0.0;
    displayImage = false;
    imageOpasity = 0.0;
    notifyListeners();
  }
}
