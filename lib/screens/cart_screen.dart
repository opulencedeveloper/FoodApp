import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../provider/orders.dart';
import '../provider/auth.dart';

import "../screens/orders_screen.dart";

import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        //iconTheme: IconThemeData(
        //  color: //Theme.of(context).colorScheme.secondary,
       // ),
        //leading: BackButton(
        //color: Theme.of(context).colorScheme.secondary,
        //),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: cart.items.isEmpty
              ? Container(
                  height: mediaQuery.size.height - AppBar().preferredSize.height - mediaQuery.padding.top,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    image: DecorationImage(
                      scale: 5.0,
                      //fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/empty-cart.png",
                        //fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomCenter, // This aligns the child of the container
                  child: Padding(
                    padding: EdgeInsets.only(bottom: (mediaQuery.size.height - AppBar().preferredSize.height - mediaQuery.padding.top) * 0.35), //some spacing to the child from bottom
                    child: Text(
                      "Cart is Empty",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: (mediaQuery.size.height - AppBar().preferredSize.height - mediaQuery.padding.top) * 0.85,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (ctx, i) => CartFoodItem(
                          id: cart.items.values.toList()[i].id,
                          cartFoodId: cart.items.keys.toList()[i],
                          price: cart.items.values.toList()[i].price,
                          quantity: cart.items.values.toList()[i].quantity,
                          food: cart.items.values.toList()[i].food,
                          imageUrl: cart.items.values.toList()[i].imageUrl,
                        ),
                      ),
                    ),
                    Container(
                      height: (mediaQuery.size.height - AppBar().preferredSize.height - mediaQuery.padding.top) * 0.15,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        //vertical: 20,
                      ),
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: const Text(
                          "Total",
                          style: TextStyle(
                            //fontSize: 33,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "\$${cart.totalAmount.toStringAsFixed(2)}\n",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(
                                text: "Free Domestic Shiping",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Container(
                          height: mediaQuery.size.height * 0.08,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                icon: Icon(Icons.arrow_left_outlined, color: Theme.of(context).colorScheme.secondary),
                                label: Text(
                                  "CHECK OUT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                onPressed: cart.items.isEmpty
                                    ? null
                                    : () {
                                        Provider.of<Orders>(context, listen: false).addOrder(
                                          cart.items.values.toList(),
                                          cart.totalAmount,
                                          authData.token,
                                        );
                                        cart.clearCart();
             Navigator.pushNamedAndRemoveUntil(context, OrdersScreen.routeName, (r) => false);                           //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
                                      },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
