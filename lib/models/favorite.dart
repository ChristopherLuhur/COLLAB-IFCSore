import 'package:flutter/foundation.dart';
import 'travel.dart';

class Favorite with ChangeNotifier {
  final List<Travel> _favoriteTravels = [];

  List<Travel> get favoriteTravels => _favoriteTravels;

  void addFavorite(Travel travel) {
    if (!_favoriteTravels.contains(travel)) {
      _favoriteTravels.add(travel);
      notifyListeners();
    }
  }

  void removeFavorite(Travel travel) {
    _favoriteTravels.remove(travel);
    notifyListeners();
  }

  bool isFavorite(Travel travel) {
    return _favoriteTravels.contains(travel);
  }
}
