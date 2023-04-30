import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/museum_provider.dart';
import 'museum_screen.dart';
import '../widget/museum_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final museumsData = Provider.of<MuseumProvider>(context).searchedMuseums;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Поиск",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  Provider.of<MuseumProvider>(context, listen: false)
                      .searchMuseums(value);
                });
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Поиск",
                  hintText: "Найти",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 13),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: museumsData.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(MuseumScreen.routeName,
                            arguments: museumsData[index].id);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: MuseumItem(
                        museumItem: museumsData[index],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
