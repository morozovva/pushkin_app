import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import 'catalog_screen.dart';
import 'map_screen.dart';
import 'search_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "tabs-screen";

  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Widget> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [const CatalogScreen(), const SearchScreen(), const MapScreen()];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: ThemeColors.lightBlue),
        child: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.view_stream),
                label: "Список",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Поиск",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.place),
                label: "Карта",
              ),
            ]),
      ),
    );
  }
}
