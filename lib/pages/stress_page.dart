import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/components/stress_card.dart';
import 'package:tui/providers/stress_list_provider.dart';
import 'package:tui/providers/temporary_stress_provider.dart';
import 'package:tui/providers/animated_state_provider.dart';
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
    final animatedState = watch(animatedStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ストレス一覧'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: stresses.stressList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StressCard(
                        stresses.stressList[index], index, popUpMenuSelected);
                  },
                ),
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: animatedState.imageOpasity,
                  child: Center(
                    child: SizedBox(
                      height: 280,
                      width: 280,
                      child: Image.asset('images/tornado.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                animatedState.setImageOpacity(1.0);
                animatedState.setRadian(animatedState.radian + 3.141592);
                animatedState.setP(0.25);
                animatedState.setHorizonPosition(600);
                animatedState.setVerticalPosition(700);
                // sleep(const Duration(seconds: 5));
                // stresses.resetStress();
                // animatedState.resetAnimatedState();
              },
              child: const Text('吹き飛ばす！！'),
            ),
          ],
        ),
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
        temporaryStress.setStressTitle(stress.title);
        temporaryStress.setStressCategory(stress.category);
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

  Future<List<Function>> waitFiveSeconds(
      StressList stresses, AnimatedState animatedState) {
    sleep(const Duration(seconds: 5));
    return Future<List<Function>>.value(
        [stresses.resetStress, animatedState.resetAnimatedState]);
  }
}
