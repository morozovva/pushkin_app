import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/back_button.dart';
import '../provider/exhibition_provider.dart';
import 'item_list_screen.dart';

class ExhibitionScreen extends StatelessWidget {
  static const routeName = "/exhibition-screen";
  const ExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exhibitionID = ModalRoute.of(context)?.settings.arguments as String;
    final exhibition = Provider.of<ExhibitionProvider>(context, listen: false)
        .getExhibition(exhibitionID);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: const CircularBackButton(),
      body: Column(children: [
        SizedBox(
          height: 230,
          child: Image.network(
            exhibition.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exhibition.title,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${exhibition.time}, ${exhibition.date}",
                style: Theme.of(context).textTheme.bodySmall,
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 13, 20, 30),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.secondary)),
                        onPressed: () => Navigator.of(context).pushNamed(
                            ItemListScreen.routeName,
                            arguments: exhibitionID),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Экспонаты",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    Text("Описание выставки",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      exhibition.description,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
