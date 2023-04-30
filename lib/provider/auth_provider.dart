import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token = "";
  late DateTime _expiryDate = DateTime.now();
  late String _userId = "";
  Timer? _authTimer;

  ///проверка, авторизовался ли пользователь
  bool get isAuth {
    return token != "";
  }

  ///геттер токена
  String get token =>
      (_expiryDate.isAfter(DateTime.now()) && _token != "") ? _token : "";

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=[API_KEY]";

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expiresIn"],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token);
      prefs.setString('userId', _userId);
      prefs.setString('expiryDate', _expiryDate.toIso8601String());
    } on Exception catch (e) {
      throw e;
    }
  }

  ///проводит попытку авто-входа в приложение
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }
    final expiryDate = DateTime.parse(prefs.getString('expiryDate')!);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = prefs.getString("token")!;
    _userId = prefs.getString("userId")!;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  ///регистрация в приложении по [email] и [password]
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  ///вход в приложение по [email] и [password]
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  ///выход из приложения
  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiryDate = DateTime.now();
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpirey = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(
      Duration(seconds: timeToExpirey),
      () => logout(),
    );
  }
}
