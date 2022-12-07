import "dart:convert";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class FavouriteFoodsItems {
  final String id;
  final String food;
  final double price;
  final String imageUrl;
  // bool isFavorite = false;

  FavouriteFoodsItems({
    required this.id,
    required this.food,
    required this.price,
    required this.imageUrl,
    // required this.isFavorite,
  });
}

class FavouriteFoods with ChangeNotifier {
  List<FavouriteFoodsItems> _favouriteMeals = [];

  List<FavouriteFoodsItems> get favouriteMeals {
    return [
      ..._favouriteMeals
    ];
  }

  String userId;
  String token;
  FavouriteFoods(this.userId, this.token, this._favouriteMeals);

  int get favLen {
    return _favouriteMeals.length;
  }

  void toggleFavoriteStat(String id) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == id);
    //if its -1, id, wasnt found
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      notifyListeners();
    } else {
      //final url = Uri.parse("https://shop-app-97057-default-rtdb.firebaseio.com/products.json?auth=$authToken");

      notifyListeners();
    }
  }

  Future<void> addItem(String favId, double price, String food, String imageUrl, bool isFav, String? token) async {
    final url = Uri.parse("https://my-shop-app-5a251-default-rtdb.firebaseio.com/userFavorites/$userId/$favId.json?auth=$token");
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == favId);
    if (existingIndex >= 0) {
      final response = await http.delete(url);
      _favouriteMeals.removeAt(existingIndex);
      notifyListeners();
      print(json.decode(response.body));
    } else {
      //try { //try catch was uncommented here beacuse we are already doing it on the widget, on the edit_product_screen where we called this function using "provider"
      final response = await http.post(
        url,
        body: json.encode({
          "food": food,
          "imageUrl": imageUrl,
          "price": price,
        }),
      );

      print(json.decode(response.body));
      final newProduct = FavouriteFoodsItems(
        id: favId,
        price: price,
        food: food,
        imageUrl: imageUrl,
        //  isFavorite: isFav,
        //id: json.decode(response.body)["name"].toString(),
      );
      _favouriteMeals.add(newProduct);
    }

    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  Future<void> fetchAndSetMyFav() async {
    //final url = Uri.parse("https://my-shop-app-5a251-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$token");
    final url = Uri.parse("https://my-shop-app-5a251-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$token");
    final response = await http.get(url);
    final List<FavouriteFoodsItems> loadedProducts = [];
    print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null || extractedData.isEmpty) {
      print("fetch and set  fav is null");
      return;
    }
    extractedData.forEach((favId, favData) {
      favData.forEach((prodIId, prodDData) {
        loadedProducts.add(FavouriteFoodsItems(
          id: favId,
          food: prodDData["food"],
          price: prodDData["price"],
          imageUrl: prodDData["imageUrl"],
        ));
      });
    });
    _favouriteMeals = loadedProducts;
    notifyListeners();
  }
}
