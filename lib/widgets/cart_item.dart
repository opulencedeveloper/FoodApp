import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../provider/cart.dart";

class CartFoodItem extends StatelessWidget {
  final String id;
  final String cartFoodId;
  final double price;
  final int quantity;
  final String food;
  final String imageUrl;

  const CartFoodItem({
    required this.id,
    required this.price,
    required this.cartFoodId,
    required this.quantity,
    required this.food,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(title: const Text("Are you Sure"), content: const Text("Do you want to remove item from cart"), actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).reduceItem(cartFoodId);
                Navigator.of(ctx).pop(false);
              },
            ),
          ]),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            title: Text(food),
            subtitle: Text("Total: \$${(price * quantity)}"),
            trailing: Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                icon: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(Icons.double_arrow),
                ),
                label: Text(
                  "$quantity x",
                  style: const TextStyle(fontSize: 15),
                ),
                // textColor: Theme.of(context).errorColor,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
