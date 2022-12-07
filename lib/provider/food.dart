import "dart:convert";

import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;

class Food with ChangeNotifier {
  final String id;
  final String food;
  final String type;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Food({
    required this.id,
    required this.food,
    required this.type,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse("https://shop-app-97057-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      //the two error handling here is corectm see why at class 256
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
