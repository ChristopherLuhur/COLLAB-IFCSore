import 'package:flutter/material.dart';
import 'package:travel_apps/models/carts.dart';
import 'package:provider/provider.dart';
import 'package:travel_apps/widgets/list_cart.dart';

class Cart extends StatelessWidget {
  // ignore: use_super_parameters
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<Carts>(
                builder: (context, carts, child) {
                  return ListView.builder(
                    itemCount: carts.carts.length,
                    itemBuilder: (context, index) {
                      final cart = carts.carts[index];
                      return CartListTile(
                        cart: cart,
                        onDelete: () {
                          Provider.of<Carts>(context, listen: false).removeCart(cart);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Purchase'),
                      content: const Text('Are you sure you want to buy these tickets?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            final carts = context.read<Carts>();
                            carts.moveItemsToHistory();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buy Ticket Successful!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pop(); 
                          },
                          child: const Text('Buy'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Buy - Rp. ${context.watch<Carts>().totalPrice}"),
            ),
          ],
        ),
      ),
    );
  }
}
