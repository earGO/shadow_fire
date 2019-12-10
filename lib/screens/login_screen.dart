import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connected/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
            child: Container(
              width: screenWidth * .55,
              height: screenHeight * .055,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 6
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: screenWidth * .055,
                    height: screenWidth * .055,
                    child: Image.asset('google_logo.png'),
                  ),
                  Text("Login with Google"),
                ],
              ),
            ),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false)
                .loginWithGoogle()),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
