import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
//import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import '../provider/food.dart';
import '../provider/foods.dart';
import "../provider/cart.dart";
import "../screens/cart_screen.dart";
import "./search_result.dart";

class DataSearch extends SearchDelegate<String?> {
  bool check = false;
  final recentCities = [
    Food(
      id: "p1",
      food: "Rice",
      type: "Rice",
      description: "of Lorem Ipsum.",
      price: 22.9,
      imageUrl: "https://i.ibb.co/RHvXmzf/images-2022-06-11-T220129-450.jpg",
    ),
    Food(
      id: "p1",
      food: "Yam",
      type: "Yam",
      description: "of Lorem Ipsum.",
      price: 22.9,
      imageUrl: "https://i.ibb.co/RHvXmzf/images-2022-06-11-T220129-450.jpg",
    ),
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Consumer<Cart>(
        builder: (_, cartBadge, ch) => Badge(
          animationType: BadgeAnimationType.fade,
          //toAnimate: false,
          badgeContent: Text("${cartBadge.cartItemCount}"),
          position: BadgePosition.topStart(),
          child: ch,
        ),
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //final myFood = recentCities ? Provider.of<Foods>(context, listen: false).findSearchFoodType(query) : Provider.of<Foods>(context, listen: false).findSearch(query);
    final myFood = check ? Provider.of<Foods>(context, listen: false).findSearchFoodType(query) : Provider.of<Foods>(context, listen: false).findSearch(query);
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: myFood.length,
      itemBuilder: (ctx, i) => SearchResult(
        food: myFood[i].food,
        id: myFood[i].id,
        imageUrl: myFood[i].imageUrl,
        amount: myFood[i].price,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 200,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //toBeginningOfSentenceCase(query);
    //query = sentenceCase(query);
    final suggestionList = query.isEmpty ? recentCities : Provider.of<Foods>(context, listen: false).findSearch(query);
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          check = true;
          // query = suggestionList[index].type;
          //close(context, suggestionList[index].type);
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].food.substring(0, query.length),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].food.substring(query.length),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        //trailing: Provider.of<Foods>(context, listen: false).findSearch(query).isEmpty ? Text("aa") : null,
      ),
      itemCount: suggestionList.length,
    );
  }
}
