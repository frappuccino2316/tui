import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tui/components/stress_card.dart';
import 'package:tui/providers/stress_list_provider.dart';
import 'package:tui/models/stress.dart';

class StressPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final stresses = watch(stressProvider);

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
        onPressed: () => print('test'),
        tooltip: '追加',
        child: const Icon(Icons.add),
        key: const Key('addButton'),
      ),
    );
  }

  void popUpMenuSelected(BuildContext context, String selected, int index) {
    print('selected!');
  }

  // void popUpMenuSelected(BuildContext context, String selected, int index,
  //     Wish originalWish, ScopedReader watch) async {
  //   final wishes = watch(wishListProvider);

  //   switch (selected) {
  //     case '編集':
  //       final Wish? wish = await Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => EditWishPage(originalWish)));
  //       if (wish != null) {
  //         _wishRepository.editWish(originalWish.key, wish);
  //         wishes.editWishInWishList(index, wish);
  //       }
  //       break;
  //     case '削除':
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) => AlertDialog(
  //                 title: Text(originalWish.title),
  //                 content: Text(originalWish.description),
  //                 actions: [
  //                   IconButton(
  //                     icon: const Icon(Icons.delete),
  //                     color: Colors.red,
  //                     onPressed: () {
  //                       _wishRepository.deleteWish(originalWish.key);
  //                       wishes.deleteWish(index);
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ));
  //       break;

  //     default:
  //       break;
  //   }
  // }
}
