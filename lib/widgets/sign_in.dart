import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import "../provider/auth.dart";
import "../provider/password_obsure.dart";

import "../screens/auth_screen.dart";

class SignIn extends StatefulWidget {
  final VoidCallback signIn;
  const SignIn({Key? key, required this.signIn}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'username': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(title: Text("An Error Occurerd"), content: Text(message), actions: [
              FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  })
            ]));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).signIn(
        _authData["email"] as String,
        _authData["password"] as String,
      );
    } on HttpException catch (error) {
//HttpException is from the file u created in the models folder, u caught and passed this exception in the auth.dart file
      var errorMessage = "Authentication failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is to a valid email address";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Could not find a user with that email";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid password";
      }
      _showErrorDialog(errorMessage);
      // setState(() {
      //   _isLoading = false;
      // });
      // return;
    } catch (error) {
      const errorMessage = "Could not authenticate you, Please try again later. ";
      _showErrorDialog(errorMessage);
      // setState(() {
      //   _isLoading = false;
      // });
      // return;
    }
    setState(() {
      _isLoading = false;
    });
    //widget.signIn();
    // Navigator.of(context).pop;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.7,
        child: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.1,
                    width: double.infinity,
                    child: const FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign-in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                TextFormField(
                  // controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    //fillColor: Colors.white,
                    //filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value as String;
                  },
                ),

                // Container(
                //   decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                //   height: constraints.maxHeight * 0.025,
                // ),

                // Container(
                //   decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                //   height: constraints.maxHeight * 0.025,
                // ),
                Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  ////height: constraints.maxHeight * 0.13,
                  child: Consumer<PasswordObsure>(builder: (_, obsure, _n) {
                    return TextFormField(
                      // controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obsure.passwordObsure();
                            // setState(() {
                            //   obscure = !obscure;
                            // });
                          },
                          child: obsure.passwordObsureMode ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: obsure.passwordObsureMode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value as String;
                      },
                    );
                  }),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                    height: constraints.maxHeight * 0.075,
                    width: constraints.maxWidth * 0.2,
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                        child: GestureDetector(
                      onTap: widget.signIn,
                      child: Text("Forgot Password?"),
                    )),
                  ),
                ),

                SizedBox(
                  height: constraints.maxHeight * 0.08,
                ),

                Container(
                  //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  height: constraints.maxHeight * 0.1,
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          child: Text("Sign in"),
                          onPressed: _submit,
                        ),
                ),
                Container(
                  //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  height: constraints.maxHeight * 0.078,
                  width: double.infinity,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    FittedBox(
                      child: Text(
                        "Don't have an account ? ",
                      ),
                    ),
                    TextButton(
                      child: FittedBox(child: Text("Sign-up")),
                      onPressed: widget.signIn,
                    )
                  ]),
                ),
              ]);
            })));
  }
}
