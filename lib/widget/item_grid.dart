import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/item_provider.dart';
import '../screen/item_screen.dart';

class ItemGrid extends StatelessWidget {
  const ItemGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context, listen: false).items;
    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ItemScreen.routeName, arguments: items[index].id),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    items[index].imageUrl,
                    height: 56,
                    width: 56,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const SizedBox(
                          height: 56,
                          width: 56,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Text(
                    items[index].title,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ]),
      ),
      itemCount: items.length,
    );
  }
}
