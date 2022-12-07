import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/search_bar.dart';
import '../widgets/most_rated.dart';
import '../provider/auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import "../screens/profile_screen.dart";

class TopWidget extends StatelessWidget {
  const TopWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final userName = Provider.of<Auth>(context).useName;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03,
      ),
      Container(
        width: double.infinity,
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.07 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.07,
        // margin: EdgeInsets.only(top: constraints.maxHeight * 0.0175),
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // fit: BoxFit.contain,
            Container(
              //width: constraints.maxWidth * 0.37,
              height: constraints.maxHeight * 0.5,
              // margin: EdgeInsets.only(top: constraints.maxHeight * 0.0175),
              //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: FittedBox(
                child: userName == null
                    ? const CircularProgressIndicator()
                    : Text(
                        "Hello $userName",
                        maxLines: 1,
                        // maxFontSize: 50,
                        //minFontSize: 16,
                        style: const TextStyle(
                          //fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),

            FittedBox(
              //alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.account_circle,
                  size: isLandscape ? (mediaQuery.size.height- mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.065 * 2: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.065,
                  color: Theme.of(context).primaryColor,
                  //Colors.grey[800],
                ),
                // radius: constraints.maxHeight * 0.08,
              ),
            ),
          ]);
        }),
      ),
      Container(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //   color: Colors.red,
        // ) //,

        //     ),
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.1 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.1,
 width: isLandscape ?   mediaQuery.size.width * 0.75 * 2 :
mediaQuery.size.width * 0.75,
        child: FittedBox(
          alignment: Alignment.topLeft,
          child: Text(
            'Find amazing recipe for\nyour meal',
            maxLines: 2,
            style: TextStyle(
              //fontSize: 25,
              // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.02 * 2: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.02,
      ),
      Container(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06,
        child: TextField(
          readOnly: true,
          //FocusScope.of(context).unfocus(),
          //enabled: false, //disable kwyboard
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
          onTap: () {
            //FocusScope.of(context).unfocus();

            showSearch(
              context: context,
              delegate: DataSearch(),
            );
          },
        ),
      ),
      SizedBox(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.04 * 2: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.04,
      ),
      Container(
        // width: double.infinity,
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.33 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.33,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: isLandscape ? mediaQuery.size.width * 0.05 * 2: mediaQuery.size.width * 0.05,
          top: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.05 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[800],
        ),
        child: const MostRated(),
      ),
      SizedBox(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03,
      ),
      Container(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.04 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.04,
        // width: constraints.maxWidth * 0.25,
        //padding: EdgeInsets.symmetric(
        //vertical: 5,
        //),
        // child:  Alignment.centerLeft,
        child: FittedBox(
          child: Text(
            "Category",
            maxLines: 1,
            style: TextStyle(
              //  fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(
        height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.015 * 2: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.015,
      ),
    ]);
  }
}
