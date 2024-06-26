import 'package:travel_apps/data/travels.dart';
import 'package:travel_apps/models/travel.dart';

class Travels {
  late List<Travel> _travels;

  List<Travel> get travels => _travels;

  Travels() {
    _travels = [
      ...travelsData.map((travel) => Travel(
          nama: travel["nama"],
          gambar: travel["gambar"],
          rating: travel["rating"],
          hargaTiket: travel["hargaTiket"]))
    ];
  }
}
