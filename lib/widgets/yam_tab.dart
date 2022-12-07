import "package:flutter/material.dart";

import "package:provider/provider.dart";

import "../provider/foods.dart";
import "../provider/favourite.dart";
import "../provider/auth.dart";



import "../screens/food_details_screen.dart";

class YamTab extends StatelessWidget {
  const YamTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myFood = Provider.of<Foods>(context, listen: false).find("Yam");
      final favFoodData = Provider.of<FavouriteFoods>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ListView.builder(
        shrinkWrap: true,

        // physics: NeverScrollableScrollPhysics(),

        primary: true,
        itemCount: myFood.length,
        itemBuilder: (ctx, i) {
          return LayoutBuilder(builder: (ctx, constraints) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: Container(
                  //height: constraints.maxHeight * 0.2,

                  width: constraints.maxWidth * 0.15,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(myFood[i].imageUrl, fit: BoxFit.cover),
                  ),
                ),
                title: Text(myFood[i].food),
                subtitle: Text("\$${myFood[i].price}"),
                trailing: IconButton(
                          icon: Consumer<FavouriteFoods>(
                            builder: (_, cartBadge, _n) => cartBadge.isMealFavorite(myFood[i].id) ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark, color: Colors.grey),
                          ),
                          onPressed: () {
                            favFoodData.addItem(myFood[i].id, myFood[i].price, myFood[i].food, myFood[i].imageUrl, false, authData.token);
                          },
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(FoodDetailsScreen.routeName, arguments: myFood[i].id);
                },
              ),
            );
          });
        });
  }
}
