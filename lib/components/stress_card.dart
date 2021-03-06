import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/models/stress.dart';
import 'package:tui/providers/animated_state_provider.dart';
import 'package:tui/providers/stress_list_provider.dart';
import 'package:tui/providers/temporary_stress_provider.dart';

@immutable
class StressCard extends ConsumerWidget {
  final Stress stress;
  final int index;
  final Function popUpMenuSelected;

  const StressCard(this.stress, this.index, this.popUpMenuSelected);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final stresses = watch(stressProvider);
    final temporaryStress = watch(temporaryStressProvider);
    final animatedState = watch(animatedStateProvider);

    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      transform: Matrix4.translationValues(
          animatedState.getHorizonPositionByIndex(index),
          animatedState.getVerticalPositionByIndex(index),
          0),
      curve: Curves.bounceInOut,
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        transform: Matrix4.diagonal3Values(animatedState.p, animatedState.p, 1),
        curve: Curves.bounceOut,
        child: AnimatedContainer(
          duration: const Duration(seconds: 5),
          transform: Matrix4.rotationZ(animatedState.getRadianByIndex(index)),
          curve: Curves.bounceIn,
          onEnd: () {
            stresses.resetStress();
            animatedState.resetAnimatedState();
          },
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: ListTile(
                title: Text(
                  stress.title,
                  key: const Key('stressTitle'),
                ),
                subtitle: Text(stress.category),
                trailing: PopupMenuButton<String>(
                  onSelected: (String selected) {
                    popUpMenuSelected(context, selected, index, stress,
                        stresses, temporaryStress);
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        child: Text('??????'),
                        value: '??????',
                      ),
                      const PopupMenuItem(
                        child: Text('??????'),
                        value: '??????',
                      ),
                    ];
                  },
                ),
                key: const Key('stressItem'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
