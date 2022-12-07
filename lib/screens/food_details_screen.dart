import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:badges/badges.dart';
import 'package:auto_size_text/auto_size_text.dart';

import "../provider/foods.dart";
import "../provider/cart.dart";

import "../widgets/add_to_cart.dart";
import "../screens/cart_screen.dart";

class FoodDetailsScreen extends StatelessWidget {
  static const routeName = "/food-detail";

  final ScrollController controllerOne = ScrollController();
  FoodDetailsScreen({
    Key? key,
  }) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final foodId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedFood = Provider.of<Foods>(context, listen: false).findById(foodId);
    final mediaQuery = MediaQuery.of(context);
    final cart = Provider.of<Cart>(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    print("foo detail");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: isLandscape ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              // construct the profile details widget here
              Container(
                height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.45 * 2: (mediaQuery.size.height - mediaQuery.padding.top) * 0.45,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[8],
                      ),
                      child: Image.network(
                        loadedFood.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.01 * 2: (mediaQuery.size.height - mediaQuery.padding.top) * 0.01,
                      left: isLandscape ? mediaQuery.size.width * 0.02 * 2: mediaQuery.size.width * 0.02,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_outlined),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: isLandscape ? (mediaQuery.size.width - mediaQuery.padding.top) * 0.01 : (mediaQuery.size.height - mediaQuery.padding.top) * 0.01,
                      right: mediaQuery.size.width * 0.02,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Consumer<Cart>(
                          builder: (_, cartBadge, ch) => Badge(
                            animationType: BadgeAnimationType.fade,
                            //toAnimate: false,
                            badgeContent: Text("${cartBadge.cartItemCount}"),
                            position: BadgePosition.topStart(),
                            child: ch,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              Navigator.of(context).pushNamed(CartScreen.routeName);
                            },
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.55 * 2: (mediaQuery.size.height - mediaQuery.padding.top) * 0.55,
                decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.03,
                ),
                child: LayoutBuilder(builder: (ctx, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Container(
                          //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                          width: constraints.maxWidth * 0.7,
                          height: constraints.maxHeight * 0.1,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              loadedFood.food,
                              maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                          width: constraints.maxWidth * 0.15,
                          height: constraints.maxHeight * 0.17,

                          // alignment: Alignment.topLeft,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "\$${loadedFood.price}",
                              maxLines: 1,
                              style: TextStyle(
                                  //fontSize: 21,
                                  //fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ]),

                      Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
 height: isLandscape ? constraints.maxHeight * 0.06 * 2: constraints.maxHeight * 0.06,
                        width: double.infinity,
                        //alignment: Alignment.topLeft,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enjoy your favorite ${loadedFood.food}",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.grey,
                              //fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.07,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                        //width: double.infinity,
                        child: const Divider(),
                      ),
                      Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                        height: constraints.maxHeight * 0.07,
                        width: double.infinity,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Description",
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.38,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                        //width: double.infinity,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: controllerOne,
                          child: SingleChildScrollView(
                            controller: controllerOne,
                            //primary: false,
                            // scrollDirection: Axis.vertical,
                            child: Text(
                              loadedFood.description,
                              style: TextStyle(
                                //fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      // SizedBox(height: constraints.maxHeight * 0.02),
                      Container(
                        height: constraints.maxHeight * 0.13,
                        width: double.infinity,
                        child: AddToCart(loadedFood: loadedFood),
                      ),
                      Container(decoration: BoxDecoration(border: Border.all(color: Colors.green)), height: constraints.maxHeight * 0.02),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
