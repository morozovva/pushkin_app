import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/item_provider.dart';
import 'qr_screen.dart';
import '../widget/item_grid.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});
  static const routeName = "/item-list-screen";

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final exhId = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<ItemProvider>(context)
          .fetchItems(exhId)
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Экспонаты",
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(QRScreen.routeName),
            icon: Icon(
              Icons.qr_code_2,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 18),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ItemGrid(),
      ),
    );
  }
}
