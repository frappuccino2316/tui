import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/components/stress_card.dart';
import 'package:tui/providers/stress_list_provider.dart';
import 'package:tui/providers/temporary_stress_provider.dart';
import 'package:tui/models/stress.dart';
import 'package:tui/pages/add_stress_page.dart';
import 'package:tui/pages/edit_stress_page.dart';

@immutable
class StressPage extends ConsumerWidget {
  const StressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final stresses = watch(stressProvider);
    final temporaryStress = watch(temporaryStressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ストレス一覧'),
      ),
      body: ListView.builder(
          itemCount: stresses.stressList.length,
          itemBuilder: (BuildContext context, int index) {
            return StressCard(
                stresses.stressList[index], index, popUpMenuSelected);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Stress? stress = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddStressPage()));
          if (stress != null) {
            stresses.addStress(stress);
          }
          temporaryStress.reset();
        },
        tooltip: '追加',
        child: const Icon(Icons.add),
        key: const Key('addButton'),
      ),
    );
  }

  void popUpMenuSelected(
      BuildContext context,
      String selected,
      int index,
      Stress stress,
      StressList stressList,
      TemporaryStress temporaryStress) async {
    switch (selected) {
      case '編集':
        final Stress? editedStress = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EditStressPage(temporaryStress)));
        if (editedStress != null) {
          stressList.editStress(editedStress, index);
        }
        break;

      case '削除':
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(stress.title),
                  content: Text(stress.category),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        stressList.deleteStress(index);
                        temporaryStress.reset();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
        break;

      default:
        break;
    }
  }
}
