import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/widgets/cart_item.dart';
import "dart:convert";

import './cart.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> foods;
  final DateTime orderTime;
  bool expanded;

  OrderItem({
    required this.id,
    required this.totalAmount,
    required this.foods,
    required this.orderTime,
    this.expanded = false,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  //Orders({required this._orders});

  List<OrderItem> get orders {
    return [
      ..._orders
    ];
  }

  String userId;
  Orders(this.userId, this._orders);
  int get ordLength {
    return _orders.length;
  }

  Future<void> addOrder(List<CartItem> cartFoods, double total, String? token) async {
    final url = Uri.parse("https://my-shop-app-5a251-default-rtdb.firebaseio.com/orders.json?auth=$token");
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "creatorId": userId,
          "dateTime": timeStamp.toIso8601String(),
          "foods": cartFoods
              .map((cp) => {
                    "id": cp.id,
                    "food": cp.food,
                    "quantity": cp.quantity,
                    "imageUrl": cp.imageUrl,
                    "price": cp.price,
                  })
              .toList(),
        }));
    print("order");
    print(json.decode(response.body));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)["name"].toString(),
        totalAmount: total,
        foods: cartFoods,
        orderTime: timeStamp,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders(String? token) async {
    final filterString = {
      "auth": token,
      'orderBy': '"creatorId"',
      'equalTo': '"$userId"',
    };
    var url = Uri.https("my-shop-app-5a251-default-rtdb.firebaseio.com", "/orders.json", filterString);
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          totalAmount: orderData["amount"],
          orderTime: DateTime.parse(orderData["dateTime"]),
          foods: (orderData["foods"] as List<dynamic>).map((item) => CartItem(id: item["id"], price: item["price"], quantity: item["quantity"], food: item["food"], imageUrl: item["imageUrl"])).toList(),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }
}
