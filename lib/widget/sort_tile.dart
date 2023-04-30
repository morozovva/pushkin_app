import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/sorting_helper.dart';
import '../provider/museum_provider.dart';

class SortTile extends StatelessWidget {
  final SortingType type;
  const SortTile({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 45,
        child: ListTile(
          title: Text(
            SortingHelper.getValue(type),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        Provider.of<MuseumProvider>(context, listen: false).sortMuseums(type);
        Navigator.pop(context);
      },
    );
  }
}
