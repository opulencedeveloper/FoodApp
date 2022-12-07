import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import "../provider/auth.dart";
import "../widgets/sign_in.dart";
import "../widgets/sign_up.dart";
import "../screens/tabs_screen.dart";

enum AuthMode { SignUp, SignIn }

class AuthScreen extends StatefulWidget {
  static const routeName = "auth-screen";
  const AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
    AuthMode _authMode = AuthMode.SignIn;
    void _signIn() {
        controller.animateToPage(0,
duration: const Duration(milliseconds: 700),
curve: Curves.easeInOut,
);
    } 
    
    final controller = PageController(initialPage: 0);
   void _signUp() {

        controller.animateToPage(1,

duration: const Duration(milliseconds: 700),

curve: Curves.easeInOut,

);

    } 
       
  


@override
void dispose() {
super.dispose();
controller.dispose();} 




    
    

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);

//  final _passwordController = TextEditingController();

    print("auth");
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView (child: Column(children: [
            
Container(
            height: isLandscape ? (mediaQuery.size.width - mediaQuery.padding.top) * 0.3 : (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              image: DecorationImage(
                scale: 3.0,
                //fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/my-logo.png",
                  //fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
 
  
                
    Container
        (
        
      height

:(mediaQuery.size.height - mediaQuery.padding.top) * 0.7,
decoration: BoxDecoration(
              color: theme.colorScheme.secondary, 
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
padding: EdgeInsets.symmetric(horizontal: (mediaQuery.size.width - mediaQuery.padding.top) * 0.07,), 

child: PageView(
    controller: controller, 
children:[
    SignIn(signIn:_signUp), 
SignUp(signUp:_signIn)
] 
) 










 





 




              ),
        ]),), 
      ),
    );
  }
}
