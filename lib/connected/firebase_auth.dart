import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../providers/users.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  User currentUser;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (
//    _expiryDate != null &&
//        _expiryDate.isAfter(DateTime.now()) &&
        _token != null || currentUser!=null) {
      return _token;
    }
    return null;
  }



  String get userId {
    return _userId;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      _token = null;
    } catch (e) {
      print("error logging out");
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null )
        return false;
      final authenticationData = await account.authentication;
      _token=authenticationData.idToken;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: authenticationData.idToken,
        accessToken: authenticationData.accessToken,
      ));
      final userData = res.user.providerData[0];
      _userId = userData.uid;
      try {
        final url =
            'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/onLogin';
        final response = await http.post(
          url,
          body: json.encode(
            {
              'user':{
                'email': userData.email,
                'displayName': userData.displayName,
                'uid': userData.uid,
                'photoUrl': userData.photoUrl,
              }
            },
          ),
          headers: {
            'Authorization': "Bearer ${authenticationData.idToken}"
          },
        );
        final decoded = await json.decode(response.body);
        User endUser = new User.fromJson(decoded);
        currentUser = endUser;
      } catch (error) {
        print('catched error: $error');
      }

    } catch (e) {
      print("Error logging with google");
      return false;
    }

    notifyListeners();
  }
}
