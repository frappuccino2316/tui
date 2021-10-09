import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';
import 'package:tui/providers/temporary_stress_provider.dart';

@immutable
class AddStressPage extends ConsumerWidget {
  const AddStressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final addState = watch(temporaryStressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('追加')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                  ),
                  onChanged: (String text) => addState.setStressTitle(text),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'カテゴリ',
                  ),
                  onChanged: (String text) => addState.setStressCategory(text),
                ),
                if (addState.isError) const Text('全て入力してください'),
                ElevatedButton(
                    child: const Text('追加'),
                    onPressed: () {
                      if (addState.checkEnteredTitleAndCategory()) {
                        Navigator.pop(
                            context,
                            Stress(addState.stress.title,
                                addState.stress.category));
                      } else {
                        addState.setTrueIntoIsError();
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
