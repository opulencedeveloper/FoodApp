import 'package:flutter/material.dart';

class CartFood extends StatelessWidget {
  final String id;
  final String food;
  final int quantity;
  final double price;

  const CartFood({
    Key? key,
    required this.id,
    required this.food,
    required this.quantity,
    required this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        minVerticalPadding: 0,
        leading: Container(
          child: Text("food"),
        ),
        title: Text("quantity"),
        subtitle: Text("quantity x"),
        trailing: Text("Total: price * quantity"),
      ),
    );
  }
}
