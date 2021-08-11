import 'package:flutter/material.dart';

class MapDataProvider with ChangeNotifier {
  String addres = '';
  String lat = '';
  String long = '';
  updataData({String address, String lat, String long}) {
    this.addres = address;
    this.lat = lat;
    this.long = long;
    notifyListeners();
  }
}
