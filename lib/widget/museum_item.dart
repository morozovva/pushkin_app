import 'package:flutter/material.dart';

import '../model/museum.dart';

class MuseumItem extends StatelessWidget {
  final Museum museumItem;
  const MuseumItem({super.key, required this.museumItem});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        margin: EdgeInsets.only(bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.network(
                museumItem.imageUrl,
                height: 244,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              height: 72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    museumItem.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    museumItem.address,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
