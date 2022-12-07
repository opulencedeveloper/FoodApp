import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import "./tabs_screen.dart";

import '../provider/orders.dart';
import '../provider/auth.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders-screen";
  const OrdersScreen({Key? key}) : super(key: key);
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<dynamic>? _allOrdersFuture;
  Future _obtainAllOrdersFuture() {
    final authData = Provider.of<Auth>(context, listen: false);
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders(authData.token);
  }

  @override
  void initState() {
    _allOrdersFuture = _obtainAllOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final dynamic appBar = AppBar(
        backgroundColor: theme.primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          "Orders",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                //Navigator.popUntil(context, ModalRoute.withName(TabsScreen.routeName));
                 Navigator.pushNamedAndRemoveUntil(context, TabsScreen.routeName, (r) => false);
                //Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
              })
        ]);

    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: orderData.orders.isEmpty
              ? Container(
                  height: isLandscape ? mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight : mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
                  child: const Center(
                    child: Text("No Orders"),
                  ),
                )
              : Container(
                  height: isLandscape ? mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight : mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
                  child: FutureBuilder(
                    future: _allOrdersFuture,
                    builder: (ctx, dataSnapShot) {
                      if (dataSnapShot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: const Text("Loading...."),
                        );
                      } else if (dataSnapShot.error != null) {
                        return Center(
                          child: Text("An error occured"),
                        );
                      } else {
                        return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Container(
                            height: isLandscape ? (mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.85 : (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.85,
                            padding: EdgeInsets.symmetric(
                              horizontal: isLandscape ? mediaQuery.size.height * 0.03 : mediaQuery.size.width * 0.03,
                              vertical: isLandscape ? (mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.05 : (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.05,
                            ),
                            child: ListView.builder(
                              itemCount: orderData.orders.length, //itemData.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  childrenPadding: const EdgeInsets.all(12),
                                  collapsedBackgroundColor: theme.primaryColor,
                                  collapsedIconColor: theme.colorScheme.secondary,
                                  collapsedTextColor: theme.colorScheme.secondary,
                                  title: Text(
                                    "This order total cost: \$${orderData.orders[index].totalAmount.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      //color: theme.colorScheme.secondary,
                                      fontSize: 18,
                                    ),
                                  ),
                                  children: orderData.orders[index].foods
                                      .map(
                                        (prod) => Row(children: [
                                          Flexible(
                                            child: Text(
                                              "\$${prod.price * prod.quantity} for ${prod.quantity} plate of ${prod.food.toLowerCase()}.",
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          //const Divider(),
                                        ]),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          ),
                          //Spacer(),
                        ]);
                      }
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
