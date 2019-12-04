import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/users.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  User _currentUser;

  bool get isAuth {
    return token != null;
  }

  User get currentUser{
    return _currentUser;
  }

  String get token {
    if (
    _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
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
      _userId = null;
      _expiryDate = null;
      if (_authTimer != null) {
        _authTimer.cancel();
        _authTimer = null;
      }
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      notifyListeners();
    } catch (e) {
      print("error logging out");
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      final authenticationData = await account.authentication;
      _token = authenticationData.accessToken;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: authenticationData.idToken,
        accessToken: authenticationData.accessToken,
      ));
      var userData = res.user.providerData[0];
      _userId = userData.uid;
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: 36000,
        ),
      );
      try {

        final url =
            'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/onLogin';
        final response = await http.post(
          url,
          body: json.encode(
            {
              'user': {
                'email': userData.email,
                'displayName': userData.displayName,
                'uid': userData.uid,
                'photoUrl': userData.photoUrl,
              }
            },
          ),
          headers: {'Authorization': "Bearer ${authenticationData.idToken}"},
        );
        final decoded = await json.decode(response.body);
        User endUser = new User.fromJson(decoded);
        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userDataPersisted = json.encode({
          'token':_token,
          'userId':_userId,
          'expiryDate':_expiryDate.toIso8601String(),
        });
        prefs.setString('userData',userDataPersisted);
      } catch (error) {
        print('catched error: $error');
      }
    } catch (e) {
      print("Error logging with google");
    }
  }



  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }
}
