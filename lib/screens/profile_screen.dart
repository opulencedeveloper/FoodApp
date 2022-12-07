import "dart:io";

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import "package:provider/provider.dart";
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import "./auth_screen.dart";

import "../provider/orders.dart";
import "../provider/foods.dart";
import "../provider/auth.dart";
import "../provider/favourite.dart";

enum FilterOptions {
  Logout,
}

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-screen";
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? _storedImage;
  @override
  void initState() {
    super.initState();
    Provider.of<Auth>(context, listen: false).fetchAndSetUserName();
    //final authData = Provider.of<Auth>(context, listen: false);
    //Provider.of<Orders>(context, listen: false).fetchAndSetOrders(authData.token);
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await File(imageFile.path).copy("${appDir.path}/$fileName");
    // final path = "files/${imageFile.name}";
    // final fileName = XFile(imageFile.path);

    // final ref = FirebaseStorage.instance.ref().child(path);
    // ref.putFile(fileName as File);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    final userName = Provider.of<Auth>(context).useName;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: theme.primaryColor,
                    height: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.45 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.45,
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: constraints.maxHeight * 0.1),
                            Container(
                              //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                              width: double.infinity,
                              height: constraints.maxHeight * 0.35,
                              child: FittedBox(
                                //alignment: Alignment.topLeft,
                                child: Badge(
                                  animationType: BadgeAnimationType.fade,
                                  //toAnimate: false,
                                  badgeContent: IconButton(
                                    iconSize: 25,
                                    icon: const Icon(Icons.add_a_photo),
                                    onPressed: _takePicture,
                                  ),
                                  badgeColor: theme.colorScheme.secondary,
                                  position: BadgePosition.bottomEnd(),
                                  child: CircleAvatar(
                                    backgroundColor: theme.colorScheme.secondary,
                                    radius: 52,
                                    backgroundImage: _storedImage != null ? FileImage(_storedImage as File) : const AssetImage("assets/images/avatar.png") as ImageProvider,
                                    // child: _storedImage == null
                                    //     ? Icon(
                                    //         Icons.account_circle,
                                    //         size: 100,
                                    //         color: theme.primaryColor,
                                    //       )
                                    //     : null,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.05),
                            Container(
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                // width: constraints.maxWidth * 0.6,
                                height: constraints.maxHeight * 0.15,
                                child: FittedBox(
                                  //alignment: Alignment.topLeft,
                                  child: userName == null
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          userName,
                                          style: TextStyle(
                                            // fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                ))
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: isLandscape ? -(mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.55 * 2 : -(mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.55,
                    left: 0,
                    right: 0,
                    child: Align(
                      //alignment: Alignment.center,
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        height:
                   isLandscape ?       (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.55 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.55,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.1 * 2 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.1,
left: isLandscape ? mediaQuery.size.width * 0.1 * 2: mediaQuery.size.width * 0.1,
                            
                          // bottom: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.08,
                        ),
                        //color: theme.colorScheme.secondary,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.spaceAround,
                            children: const [
                              ListTile(
                                leading: Icon(Icons.email),
                                title: Text(
                                  "App creator: victorkudos@gmail.com",
                                  //maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(
                                  "App creator:\n+234 818 429 7165",
                                  //maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person_add),
                                title: Text(
                                  "Add to Groups",
                                  //maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.comment),
                                title: Text(
                                  "Show all Comments",
                                  // maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: isLandscape ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.01 * 2 : (mediaQuery.size.height - mediaQuery.padding.top) * 0.01,
                    right: mediaQuery.size.width * 0.02,
                    child: PopupMenuButton(
                      onSelected: (FilterOptions selectedValue) {
                        if (selectedValue == FilterOptions.Logout) {
                          // Navigator.of(context).pop();
                          Provider.of<Auth>(context).logout();
        Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);           // Navigator.of(context).pushReplacementNamed("/");
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: theme.colorScheme.secondary,
                      ),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text('Log out'),
                          value: FilterOptions.Logout,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: isLandscape ? -(mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06 * 2 : -(mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.06,
                    right: isLandscape ? mediaQuery.size.width * 0.05 * 2 : mediaQuery.size.width * 0.05,
                    left: isLandscape ? mediaQuery.size.width * 0.05 * 2: mediaQuery.size.width * 0.05,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      color: theme.colorScheme.secondary,
                      child: Container(
                        height: isLandscape ? (mediaQuery.size.width - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.15 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.15,
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05, vertical: isLandscape ? (mediaQuery.size.width - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03 : (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.03),
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                //width: constraints.maxWidth * 0.6,
                                height: constraints.maxHeight * 0.92,

                                child: FittedBox(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    const Text(
                                      "Orders",
                                      // maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Consumer<Orders>(
                                      builder: (_, ord, _n) => Text(
                                        "${ord.ordLength}",
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          //fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              Container(
                                //decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                                //width: constraints.maxWidth * 0.6,
                                //height: constraints.maxHeight * 0.8,
                                height: constraints.maxHeight * 0.92,

                                child: FittedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Favorites",
                                        // maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Consumer<FavouriteFoods>(
                                        builder: (_, favFood, _n) => Text(
                                          "${favFood.favLen}",
                                          // maxLines: 1,
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                //width: constraints.maxWidth * 0.6,
                                //
                                // height: constraints.maxHeight * 0.77,
                                height: constraints.maxHeight * 0.92,

                                child: FittedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Reviews",
                                        //maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "0",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
