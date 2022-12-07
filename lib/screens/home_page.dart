import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/top_widget.dart';
import '../widgets/all_food_tab.dart';
import '../widgets/rice_tab.dart';
import '../widgets/soup_tab.dart';
import '../widgets/yam_tab.dart';
import '../provider/foods.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("aa");
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //appBar: appBar,
        body: SafeArea(
          child: SingleChildScrollView(
            //scrollDirection: Axis.vertical,

            child: Column(
              children: <Widget>[
                // construct the profile details widget here
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? mediaQuery.size.width * 0.04 * 2 : mediaQuery.size.width * 0.04,
                  ),
                  child: TopWidget(),
                ),

                // the tab bar with two items
                Container(
                  //height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
                  // margin: EdgeInsets.only(bottom:
//mediaQuery.size.height * 0.02),
                  //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? mediaQuery.size.width * 0.04 * 2 : mediaQuery.size.width * 0.04,
                  ),
                  height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06 * 2: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return TabBar(
                        indicatorColor: Colors.black,
                        indicatorPadding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.07,
                          vertical: constraints.maxHeight * 0.05,
                        ),

                        //indicatorSize: TabBarIndicatorSize.label,

                        indicator: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(6)),
                        labelColor: Colors.white, labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.grey,

                        tabs: [
                          SizedBox(
                              height: constraints.maxWidth * 0.05,
                              child: const FittedBox(
                                child: Text(
                                  "All",
                                  maxLines: 1,
                                  // style: TextStyle(fontSize: 14),
                                ),
                              )),
                          SizedBox(
                            height: constraints.maxWidth * 0.05,
                            child: const FittedBox(
                              child: Text(
                                "Rice",
                                maxLines: 1,
                                // style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxWidth * 0.05,
                            child: const FittedBox(
                              child: Text(
                                "Soup",
                                maxLines: 1,
                                //style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxWidth * 0.05,
                            child: const FittedBox(
                              child: Text(
                                "Yam",
                                maxLines: 1,
                                //style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.02 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.02,
                ),

                Container(
                  height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.5 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.5,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? mediaQuery.size.width * 0.04 * 2: mediaQuery.size.width * 0.04,
                  ),
                  child: const TabBarView(
                    children: [
                      AllFoodTab(),
                      RiceTab(),
                      SoupTab(),
                      YamTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
