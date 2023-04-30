import 'package:flutter/material.dart';

import 'filter_tile.dart';
import '../helpers/filter_helper.dart';

class FilteringBottomSheet extends StatefulWidget {
  const FilteringBottomSheet({super.key});

  @override
  State<FilteringBottomSheet> createState() => _FilteringBottomSheetState();
}

class _FilteringBottomSheetState extends State<FilteringBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Фильтры",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 23,
            ),
            Text(
              "Стоимость билета",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            FilterTile(type: FilterType.cheap),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
            FilterTile(type: FilterType.mid),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
            FilterTile(type: FilterType.exp),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
          ],
        ),
      ),
    );
  }
}
