import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushkin_app/widget/internet_error.dart';

import '../provider/museum_provider.dart';
import 'museum_screen.dart';
import '../widget/filtering_bottom_sheet.dart';
import '../widget/museum_item.dart';
import '../widget/sorting_bottom_sheet.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _pullRefresh();
    }
    _isInit = false;
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _isLoading = true;
    });
    Provider.of<MuseumProvider>(context, listen: false)
        .fetchMuseums()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var iconColor = isDarkMode ? Colors.white : Colors.black;
    final museumsData = Provider.of<MuseumProvider>(context).museums;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Каталог",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return GestureDetector(
                              child: const SortingBottomSheet(),
                              onTap: () {},
                            );
                          });
                    },
                    icon: Icon(
                      Icons.swap_vert,
                      color: iconColor,
                    ),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const FilteringBottomSheet();
                          });
                    },
                    icon: Icon(
                      Icons.tune,
                      color: iconColor,
                    ),
                    iconSize: 30,
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : museumsData.isEmpty
                        ? const InternetError()
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: museumsData.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  MuseumScreen.routeName,
                                  arguments: museumsData[index].id),
                              child: MuseumItem(
                                museumItem: museumsData[index],
                              ),
                            ),
                          ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
