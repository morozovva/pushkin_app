import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/exhibition.dart';

class ExhibitionProvider with ChangeNotifier {
  List<Exhibition> _exhibitions = [];

  ///геттер выставок
  List<Exhibition> get exhibitions => [..._exhibitions];

  ///возвращает выставку по ее айди
  Exhibition getExhibition(String id) {
    return _exhibitions.firstWhere((element) => element.id == id);
  }

  ///захват данных выставок по айди музея [museumId]
  Future<void> fetchExibitions(int museumId) async {
    final String url =
        "https://pushkin-app-bmft-default-rtdb.europe-west1.firebasedatabase.app/museums/$museumId/exhibitions.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Exhibition> loadedExhibitions = [];
      extractedData.forEach((exhId, exhData) {
        loadedExhibitions.add(
          Exhibition(
            id: exhId,
            title: exhData["title"],
            date: exhData["date"],
            time: exhData["time"],
            imageUrl: exhData["imageUrl"],
            description: exhData["description"],
          ),
        );
      });
      _exhibitions = loadedExhibitions;
      notifyListeners();
    } on Exception {
      const Text("no internet connection");
    }
  }
}
