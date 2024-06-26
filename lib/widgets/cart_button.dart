import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final Function() onClick;

  // ignore: use_super_parameters
  const CartButton({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: ElevatedButton(
        onPressed: onClick,
        child: const Text("Buy"),
      ),
    );
  }
}
