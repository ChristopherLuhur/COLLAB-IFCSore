import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_apps/models/favorite.dart';
import 'package:travel_apps/widgets/travel_card.dart';

class FavoriteScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<Favorite>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Destinations'),
      ),
      body: favoriteProvider.favoriteTravels.isEmpty
          ? const Center(
              child: Text(
                'No favorite destinations added yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.25,
                ),
                itemCount: favoriteProvider.favoriteTravels.length,
                itemBuilder: (context, index) {
                  final travel = favoriteProvider.favoriteTravels[index];
                  return TravelCard(travel: travel, onFavoriteToggle: () {  },);
                },
              ),
            ),
    );
  }
}
