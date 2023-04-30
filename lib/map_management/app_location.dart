import 'package:pushkin_app/map_management/map_coords.dart';

abstract class AppLocation {
  //абстрактный класс для работы карты
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}
