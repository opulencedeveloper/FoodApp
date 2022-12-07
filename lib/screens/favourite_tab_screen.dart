import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favourite.dart';

class FavouriteTabScreen extends StatefulWidget {
  const FavouriteTabScreen({Key? key}) : super(key: key);
  @override
  _FavouriteTabScreenState createState() => _FavouriteTabScreenState();
}

class _FavouriteTabScreenState extends State<FavouriteTabScreen> {
  Future<dynamic>? _allFavFuture;
  Future _obtainAllFavFuture() {
    return Provider.of<FavouriteFoods>(context, listen: false).fetchAndSetMyFav();
  }

  @override
  void initState() {
    super.initState();
    _allFavFuture = _obtainAllFavFuture();
  }

  @override
  Widget build(BuildContext context) {
    //final favData = Provider.of<Foods>(context, listen: false);
    final favvData = Provider.of<FavouriteFoods>(context);

    //final myFav = favData.favouriteMeals;
    final myFavv = favvData.favouriteMeals;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final dynamic appBar = AppBar(
      title: Text(
        "Boookmarks",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: myFavv.isEmpty
              ? Container(
                  height: isLandscape ? mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight : mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
                  child: const Center(child: Text("No Boookmarks")) ,
                )
              : FutureBuilder(
                  future: _allFavFuture,
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
                      return Container(
                        height: isLandscape ? mediaQuery.size.width - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight : mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            //primary: false,
                            // itemExtent: 100.0,
                            itemCount: myFavv.length,
                            itemBuilder: (ctx, i) {
                              return LayoutBuilder(builder: (ctx, constraints) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      //visualDensity: const //VisualDensity(vertical: 4), //increase listtile height
                                      // contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      // minVerticalPadding: 0,
                                      //minLeadingWidth: 55,
                                      leading: SizedBox(
                                        height: double.infinity,
                                        width: constraints.maxWidth * 0.15,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.network(myFavv[i].imageUrl, fit: BoxFit.cover),
                                        ),
                                      ),
                                      title: Text(myFavv[i].food, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                      trailing: Text("\$${myFavv[i].price}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                );
                              });
                            }),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}
