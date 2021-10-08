import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';

@immutable
class StressCard extends ConsumerWidget {
  final Stress stress;
  final int index;
  final Function popUpMenuSelected;

  const StressCard(this.stress, this.index, this.popUpMenuSelected);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
              popUpMenuSelected(context, selected, index, stress, watch);
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
