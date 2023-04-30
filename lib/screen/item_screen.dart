import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/back_button.dart';
import '../provider/item_provider.dart';
import '../widget/audio_player.dart';

class ItemScreen extends StatelessWidget {
  static const routeName = "/item-screen";
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemID = ModalRoute.of(context)?.settings.arguments as String;
    final item =
        Provider.of<ItemProvider>(context, listen: false).getItem(itemID)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: CircularBackButton(),
      body: Column(children: [
        Container(
          height: 250,
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 30),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    myAudioPlayer(url: item.track),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Описание экспоната",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      item.description,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
