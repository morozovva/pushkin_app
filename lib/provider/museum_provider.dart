import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/museum.dart';
import '../helpers/sorting_helper.dart';

class MuseumProvider with ChangeNotifier {
  List<Museum> _museums = [];
  List<Museum> _unfilteredMuseums = [];
  List<Museum> _searchedMuseums = [];

  ///геттер музеев
  List<Museum> get museums => [..._museums];

  ///геттер музеев для поиска
  List<Museum> get searchedMuseums => [..._searchedMuseums];

  ///возвращает музей по его айди
  Museum getMuseum(int id) {
    return _museums.firstWhere((element) => element.id == id);
  }

  ///захват данных музеев
  Future<void> fetchMuseums() async {
    const String url =
        "https://pushkin-app-bmft-default-rtdb.europe-west1.firebasedatabase.app/museums.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<Museum> loadedMuseums = [];
      extractedData.forEach((museum) {
        loadedMuseums.add(
          Museum(
            id: extractedData.indexOf(museum),
            address: museum["address"],
            title: museum["title"],
            price: museum["price"],
            imageUrl: museum["imageUrl"],
            logo: museum["logo"],
            description: museum["description"],
          ),
        );
      });
      _museums = loadedMuseums;
      _unfilteredMuseums = loadedMuseums;

      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }

  ///сортировка списка музеев по выбранному пользователем типу
  void sortMuseums(SortingType type) {
    switch (type) {
      case SortingType.alpha:
        _museums.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortingType.popular:
        _museums..shuffle();
        break;
      default:
        _museums;
    }
    notifyListeners();
  }

  ///фильтрация списка музеев по выбранным пользователем параметрам
  void filterMuseums(List<bool> filters) {
    List<Museum> list = [];
    if (filters[0]) {
      list +=
          _unfilteredMuseums.where((element) => element.price <= 300).toList();
    }
    if (filters[1]) {
      list += _unfilteredMuseums
          .where((element) => element.price > 300 && element.price <= 600)
          .toList();
    }
    if (filters[2]) {
      list +=
          _unfilteredMuseums.where((element) => element.price >= 600).toList();
    }
    if (filters.every((element) => !element)) {
      list = _unfilteredMuseums;
    }
    _museums = list;
    notifyListeners();
  }

  ///поиск музеев
  void searchMuseums(String query) {
    if (query == "") {
      _searchedMuseums = [];
      return;
    }
    _searchedMuseums = _unfilteredMuseums
        .where((el) => el.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
