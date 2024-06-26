import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_apps/models/cart.dart';
import 'package:travel_apps/models/favorite.dart';
import 'package:travel_apps/models/travel.dart';
import 'package:travel_apps/models/carts.dart';
import 'package:travel_apps/widgets/cart_button.dart';

class TravelCard extends StatefulWidget {
  final Travel travel;
  final VoidCallback onFavoriteToggle;

  // ignore: use_super_parameters
  const TravelCard({
    Key? key,
    required this.travel,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<Favorite>();
    isFavorite = favoriteProvider.isFavorite(widget.travel);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  widget.travel.gambar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        if (isFavorite) {
                          Provider.of<Favorite>(context, listen: false)
                              .addFavorite(widget.travel);
                        } else {
                          Provider.of<Favorite>(context, listen: false)
                              .removeFavorite(widget.travel);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.travel.nama,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.travel.rating,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp. ${widget.travel.hargaTiket}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                CartButton(
                  onClick: () {
                    context.read<Carts>().addCart(Cart(travel: widget.travel));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
