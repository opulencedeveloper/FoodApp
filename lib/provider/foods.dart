import "dart:convert";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

import "../provider/food.dart";

class Foods with ChangeNotifier {
  List<Food> _items = [];

  List<Food> get items {
    return [
      ..._items
    ];
  }

  List<Food> _favouriteMeals = [];

  List<Food> get favouriteMeals {
    return [
      ..._favouriteMeals
    ];
  }

  int get favLen {
    return _favouriteMeals.length;
  }

  void toggleFavoriteStat(String id) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == id); //if its -1, id, wasnt found
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      notifyListeners();
    } else {
      //final url = Uri.parse("https://shop-app-97057-default-rtdb.firebaseio.com/products.json?auth=$authToken");
      _favouriteMeals.add(items.firstWhere((meal) => meal.id == id));
      notifyListeners();
    }
  }

  bool isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  final String authToken;
  final String userId;

  Foods(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetMyFood() async {
    final filterString = {
      "auth": authToken
    };
    var url = Uri.https("my-shop-app-5a251-default-rtdb.firebaseio.com", "/products.json", filterString);
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null || extractedData.isEmpty) {
        print("fetch and set  foods is null");
        return;
      }
      final List<Food> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Food(
          id: prodId,
          food: prodData['food'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          type: prodData['type'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Food> findSearch(String query) {
    return _items.where((element) => element.food.toLowerCase().startsWith(query.toLowerCase())).toList();
  }

  List<Food> findSearchFoodType(String query) {
    return _items.where((element) => element.type.toLowerCase().startsWith(query.toLowerCase()) && element.type.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<Food> find(String id) {
    return _items.where((p) => p.type == id).toList();
  }

  Food findById(String id) {
    return _items.firstWhere((food) => food.id == id);
  }

  void addProduct() {
    notifyListeners();
  }
}
