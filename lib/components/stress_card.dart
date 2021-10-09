import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';
import 'package:tui/providers/stress_list_provider.dart';
import 'package:tui/providers/temporary_stress_provider.dart';

@immutable
class StressCard extends ConsumerWidget {
  final Stress stress;
  final int index;
  final Function popUpMenuSelected;

  StressCard(this.stress, this.index, this.popUpMenuSelected);
  // const StressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final stressList = watch(stressProvider);
    final temporaryStress = watch(temporaryStressProvider);

    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black),
        ),
        child: ListTile(
          title: Text(
            stress.title,
            key: const Key('stressTitle'),
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (String selected) {
              popUpMenuSelected(context, selected, index, stress, stressList,
                  temporaryStress);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem(
                  child: Text('編集'),
                  value: '編集',
                ),
                const PopupMenuItem(
                  child: Text('削除'),
                  value: '削除',
                ),
              ];
            },
          ),
          key: const Key('stressItem'),
        ),
      ),
    );
  }
}
