import 'package:flutter/material.dart';
import 'package:travel_apps/models/cart.dart';

class CartListTile extends StatelessWidget {
  final Cart cart;
  final VoidCallback? onDelete;

  // ignore: use_super_parameters
  const CartListTile({Key? key, required this.cart, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              cart.travel.gambar,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.travel.nama,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  cart.travel.rating,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp. ${cart.travel.hargaTiket}",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          onDelete != null ? IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
