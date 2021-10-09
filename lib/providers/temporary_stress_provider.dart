import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';

class TemporaryStress extends ChangeNotifier {
  final Stress stress = Stress('', '');

  void setStressTitle(String text) {
    stress.title = text;
    notifyListeners();
  }

  void setStressCategory(String text) {
    stress.category = text;
    notifyListeners();
  }

  void resetStress() {
    stress.title = '';
    stress.category = '';
  }
}
