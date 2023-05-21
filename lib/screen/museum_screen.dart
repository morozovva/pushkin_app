import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/back_button.dart';
import '../provider/museum_provider.dart';
import 'exhibition_list_screen.dart';

class MuseumScreen extends StatelessWidget {
  static const routeName = "/museum-screen";
  const MuseumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final museumID = ModalRoute.of(context)?.settings.arguments as int;
    final museum =
        Provider.of<MuseumProvider>(context, listen: false).getMuseum(museumID);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: const CircularBackButton(),
      body: Column(children: [
        SizedBox(
          height: 250,
          child: Image.network(
            museum.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Container(
          height: 73,
          color: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(
                museum.logo,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              museum.title,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]),
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
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(
                            ExhibitionListScreen.routeName,
                            arguments: museumID),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Выставки музея",
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
                    Text("Информация о музее",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 7,
                    ),
                    Text("Средняя стоимость билета – ${museum.price} рублей.",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      museum.description,
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
