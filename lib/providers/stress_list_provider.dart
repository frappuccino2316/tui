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

  void editStress(Stress editedStress, int index) {
    stressList[index].title = editedStress.title;
    stressList[index].category = editedStress.category;
    notifyListeners();
  }

  void deleteStress(int index) {
    stressList.removeAt(index);
    notifyListeners();
  }

  void resetStress() {
    stressList.clear();
    notifyListeners();
  }
}
