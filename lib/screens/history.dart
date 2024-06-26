import 'package:flutter/material.dart';
import 'package:travel_apps/models/carts.dart';
import 'package:travel_apps/widgets/list_cart.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<Carts>(
          builder: (context, carts, child) {
            return ListView(
              children: carts.history.map((cart) => CartListTile(cart: cart)).toList(),
            );
          },
        ),
      ),
    );
  }
}
