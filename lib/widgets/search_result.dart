import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/foods.dart';
import '../provider/cart.dart';
import "../screens/food_details_screen.dart";
import "../screens/cart_screen.dart";
import './add_to_cart.dart';

class SearchResult extends StatelessWidget {
  final String id;
  final String food;
  final String imageUrl;
  final double amount;
  const SearchResult({Key? key, required this.id, required this.food, required this.imageUrl, required this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final loadedFood = Provider.of<Foods>(context, listen: false).findById(id);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(FoodDetailsScreen.routeName, arguments: id);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      footer: Column(children: [
        Container(
          color: Colors.black38,
          width: double.infinity,
          child: Text(
            food,
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          color: Colors.black38,
          width: double.infinity,
          child: Text(
            "\$$amount",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: cart.itemNumber(loadedFood.id) < 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TextButton(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
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
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        cart.reduceItem(loadedFood.id);
                      },
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Center(
                      child: Text(
                        "${cart.itemNumber(loadedFood.id)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        cart.addItem(loadedFood.id, loadedFood.price, loadedFood.food, loadedFood.imageUrl);
                      },
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),

          //AddToCart(loadedFood: loadedFood),
        ),
      ]),
    );
  }
}
