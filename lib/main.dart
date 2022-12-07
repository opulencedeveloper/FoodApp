import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";

import "./screens/tabs_screen.dart";
import "./screens/home_page.dart";
import "./screens/food_details_screen.dart";
import "./screens/cart_screen.dart";
import "./screens/orders_screen.dart";
import "./screens/auth_screen.dart";
import "./screens/splash_screen.dart";
import "./screens/profile_screen.dart";

import "./provider/foods.dart";
import "./provider/cart.dart";
import "./provider/orders.dart";
import "./provider/auth.dart";
import "./provider/favourite.dart";
import "./provider/password_obsure.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PasswordObsure(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Foods>(
          update: (ctx, auth, allFoods) => Foods(
            auth.token.toString(),
            auth.userId,
            allFoods == null ? [] : allFoods.items,
          ),
          create: (ctx) => Foods("", "", []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrder) => Orders(
            auth.userId,
            previousOrder == null ? [] : previousOrder.orders,
          ),
          create: (ctx) => Orders("", []),
        ),
        ChangeNotifierProxyProvider<Auth, FavouriteFoods>(
          update: (ctx, auth, previousOrder) => FavouriteFoods(
            auth.userId.toString(),
            auth.token.toString(),
            previousOrder == null ? [] : previousOrder.favouriteMeals,
          ),
          create: (ctx) => FavouriteFoods("", "", []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Food App',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              fontFamily: 'Quicksand',
              colorScheme: theme.colorScheme.copyWith(
                secondary: Colors.grey[50],
                primary: Colors.orange,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[50],
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              )),
            ),
            home: auth.isAuth
                ? TabsScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
                  ),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              TabsScreen.routeName: (ctx) => TabsScreen(),
              HomePage.routeName: (ctx) => HomePage(),
              FoodDetailsScreen.routeName: (ctx) => FoodDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
            }),
      ),
    );
  }
}
