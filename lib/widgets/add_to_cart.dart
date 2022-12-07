import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../provider/cart.dart";

class AddToCart extends StatelessWidget {
  final dynamic loadedFood;
  const AddToCart({Key? key, required this.loadedFood}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    print("add to cart build");

    return cart.itemNumber(loadedFood.id) < 1
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary: Theme.of(context).colorScheme.secondary,
            ),
            child: FittedBox(
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            onPressed: () {
              cart.addItem(loadedFood.id, loadedFood.price, loadedFood.food, loadedFood.imageUrl);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Added item to cart",
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.UndoRemoveSingleItem(loadedFood.id);
                      }),
                ),
              );
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                //fit: FlexFit.tight,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      cart.reduceItem(loadedFood.id);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  //height: double.infinity,
                  child: Center(
                    child: Text(
                      "${cart.itemNumber(loadedFood.id)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                //fit: FlexFit.tight,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      cart.addItem(loadedFood.id, loadedFood.price, loadedFood.food, loadedFood.imageUrl);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          );
  }
}
