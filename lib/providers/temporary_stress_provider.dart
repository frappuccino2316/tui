import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';

final temporaryStressProvider =
    ChangeNotifierProvider((ref) => TemporaryStress());

class TemporaryStress extends ChangeNotifier {
  final Stress stress = Stress('', '');
  bool isError = false;

  void setStressTitle(String text) {
    stress.title = text;
    notifyListeners();
  }

  void setStressCategory(String text) {
    stress.category = text;
    notifyListeners();
  }

  bool checkEnteredTitleAndCategory() {
    if (stress.title != '' && stress.category != '') {
      return true;
    } else {
      return false;
    }
  }

  void setTrueIntoIsError() {
    isError = true;
  }

  void reset() {
    stress.title = '';
    stress.category = '';
    isError = false;
  }
}
