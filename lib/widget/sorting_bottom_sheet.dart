import 'package:flutter/material.dart';

import 'sort_tile.dart';
import '../helpers/sorting_helper.dart';

class SortingBottomSheet extends StatefulWidget {
  const SortingBottomSheet({super.key});

  @override
  State<SortingBottomSheet> createState() => _SortingBottomSheetState();
}

class _SortingBottomSheetState extends State<SortingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Сортировка",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            SortTile(type: SortingType.popular),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
            SortTile(type: SortingType.alpha),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
            SortTile(type: SortingType.near),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
          ],
        ),
      ),
    );
  }
}
