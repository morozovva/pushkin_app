import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/filter_helper.dart';
import '../provider/museum_provider.dart';

class FilterTile extends StatefulWidget {
  final FilterType type;
  const FilterTile({
    super.key,
    required this.type,
  });

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: CheckboxListTile(
        onChanged: (value) {
          setState(() {
            var currState = Provider.of<FilterHelper>(context, listen: false);
            currState.setValue(widget.type);
            Provider.of<MuseumProvider>(context, listen: false)
                .filterMuseums(currState.getAll);
          });
        },
        value: Provider.of<FilterHelper>(context, listen: false)
            .getByType(widget.type),
        title: Text(
          FilterHelper.getValue(widget.type),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
