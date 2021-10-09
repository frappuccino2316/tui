import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';
import 'package:tui/providers/temporary_stress_provider.dart';

@immutable
class EditStressPage extends ConsumerWidget {
  final TemporaryStress _temporaryStress;

  const EditStressPage(this._temporaryStress);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: const Text('編集')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(
                      text: _temporaryStress.stress.title),
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                  ),
                  onChanged: (String text) =>
                      _temporaryStress.setStressTitle(text),
                ),
                TextField(
                  controller: TextEditingController(
                      text: _temporaryStress.stress.category),
                  decoration: const InputDecoration(
                    labelText: 'カテゴリ',
                  ),
                  onChanged: (String text) =>
                      _temporaryStress.setStressCategory(text),
                ),
                if (_temporaryStress.isError) const Text('全て入力してください'),
                ElevatedButton(
                    child: const Text('追加'),
                    onPressed: () {
                      if (_temporaryStress.checkEnteredTitleAndCategory()) {
                        Navigator.pop(
                            context,
                            Stress(_temporaryStress.stress.title,
                                _temporaryStress.stress.category));
                      } else {
                        _temporaryStress.setTrueIntoIsError();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
