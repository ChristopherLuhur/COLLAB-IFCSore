import 'package:flutter/material.dart';
import 'package:travel_apps/models/travel.dart';

class Cart with ChangeNotifier {
  Travel travel;
  int jumlah = 0;

  Cart({required this.travel, this.jumlah = 0});
}
