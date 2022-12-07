import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../provider/foods.dart";
import "../provider/auth.dart";
import "../provider/favourite.dart";
import "../screens/food_details_screen.dart";

class AllFoodTab extends StatefulWidget {
  const AllFoodTab({Key? key}) : super(key: key);
  @override
  AllFoodTabState createState() => AllFoodTabState();
}

class AllFoodTabState extends State<AllFoodTab> {
  Future<dynamic>? _allFoodFuture;
  Future _obtainAllFoodFuture() {
    return Provider.of<Foods>(context, listen: false).fetchAndSetMyFood();
  }

  @override
  void initState() {
    super.initState();
    _allFoodFuture = _obtainAllFoodFuture();
    Provider.of<FavouriteFoods>(context, listen: false).fetchAndSetMyFav();
    Provider.of<Auth>(context, listen: false).fetchAndSetUserName();
  }

//     var _isInit = true;
// @override
//  void didChangeDependencies() {
// super.didChangeDependencies();
// if (_isInit) {
// Provider.of<Foods>(context).fetchAndSetMyFood();
// print("did change the");}
// _isInit = false;
// }
  @override
  Widget build(BuildContext context) {
    final foodData = Provider.of<Foods>(context);
    final myFood = foodData.items;
    final favFoodData = Provider.of<FavouriteFoods>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    print("tab");
    return FutureBuilder(
      future: _allFoodFuture,
      builder: (ctx, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapShot.error != null) {
            //do something
            //do error handling stuff
            return const Center(
              child: Text("An error occured"),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                primary: false,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: myFood.length,
                itemBuilder: (ctx, i) {
                  return LayoutBuilder(builder: (ctx, constraints) {
                    return Card(
                      elevation: 5,
                      // margin: const EdgeInsets.symmetric(
                      //   vertical: 8,
                      //   horizontal: 5,
                      // ),

                      child: ListTile(
                        // minVerticalPadding: 0,
                        // minLeadingWidth: 55,
                        // dense: true,
                        // visualDensity: VisualDensity(vertical: 1),
                        leading: Container(
                          width: constraints.maxWidth * 0.15,
                            height: double.infinity, 
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
      },
    );
  }
}
