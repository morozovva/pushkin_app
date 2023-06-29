import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';

import '../model/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  ///геттер экспонатов
  List<Item> get items => [..._items];

  ///возвращает экспонат по его айди
  Item? getItem(String id) {
    return _items.firstWhereOrNull((element) => element.id == id);
  }

  ///захват данных экспонатов по айди выставки [exhId]
  Future<void> fetchItems(String exhId) async {
    final String url =
        "https://pushkin-app-bmft-default-rtdb.europe-west1.firebasedatabase.app/museums/${exhId[0]}/exhibitions/$exhId/items.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Item> loadedItems = [];
      extractedData.forEach((itemId, itemData) {
        loadedItems.add(
          Item(
            id: itemId,
            title: itemData["title"],
            imageUrl: itemData["imageUrl"],
            description: itemData["description"],
            track: itemData["track"],
          ),
        );
      });
      _items = loadedItems;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }
}
