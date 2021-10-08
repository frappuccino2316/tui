import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';

final stressProvider = ChangeNotifierProvider((ref) => StressList());

class StressList extends ChangeNotifier {
  final List<Stress> stressList = [];

  void addStress(Stress stress) {
    stressList.add(stress);
    notifyListeners();
  }

  void deleteStress(int index) {
    stressList.removeAt(index);
    notifyListeners();
  }
}
