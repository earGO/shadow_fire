import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connected/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Login with Google"),
                onPressed: () => Provider.of<AuthProvider>(context,listen: false)
                    .loginWithGoogle()

              ),
            ],
          ),
        ),
      ),
    );
  }
}
