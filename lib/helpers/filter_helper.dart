import 'package:flutter/material.dart';

enum FilterType {
  cheap,
  mid,
  exp,
}

class FilterHelper with ChangeNotifier {
  var _cheap = false;
  var _mid = false;
  var _exp = false;

  static String getValue(FilterType type) {
    switch (type) {
      case FilterType.cheap:
        return "до 300 рублей";
      case FilterType.mid:
        return "300-600 рублей";
      case FilterType.exp:
        return "от 600 рублей";
      default:
        return "";
    }
  }

  bool getByType(FilterType type) {
    switch (type) {
      case FilterType.cheap:
        return _cheap;
      case FilterType.mid:
        return _mid;
      case FilterType.exp:
        return _exp;
      default:
        return false;
    }
  }

  List<bool> get getAll {
    return [_cheap, _mid, _exp];
  }

  void setValue(FilterType type) {
    switch (type) {
      case FilterType.cheap:
        _cheap = !_cheap;
        return;
      case FilterType.mid:
        _mid = !_mid;
        return;
      case FilterType.exp:
        _exp = !_exp;
        return;
      default:
        return;
    }
  }
}
