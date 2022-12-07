import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../provider/cart.dart';

class MyBadg extends StatelessWidget {
  static const routeName = "/cart";
  const MyBadg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Badge(
        badgeContent: Text("${cart.cartItemCount}"),
        position: BadgePosition.topStart(),
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
          color: Colors.white,
        ),
      ),
    );
  }
}
