import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/exhibition_provider.dart';
import '../widget/exhibition_grid.dart';

class ExhibitionListScreen extends StatefulWidget {
  const ExhibitionListScreen({super.key});
  static const routeName = "/exhibition-list-screen";

  @override
  State<ExhibitionListScreen> createState() => _ExhibitionListScreenState();
}

class _ExhibitionListScreenState extends State<ExhibitionListScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final museumId = ModalRoute.of(context)?.settings.arguments as int;
      Provider.of<ExhibitionProvider>(context)
          .fetchExibitions(museumId)
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
        title: const Text(
          "Выставки",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const ExhibitionGrid(),
      ),
    );
  }
}
