import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      final authUserData = res.user.providerData[0];
      final accessToken = (await account.authentication).accessToken;
      print('firebase user: $authUserData');
      if (res.user == null) return false;
      try {
        final url =
            'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/onLogin';
        final response = await http.post(
          url,
          body: json.encode(
            {
              'user': {
                'uid': authUserData.uid,
                'email': authUserData.email,
                'displayName': authUserData.displayName,
                'photoUrl': authUserData.photoUrl,
              },
            },
          ),
          headers: {'Authorization': "Bearer $accessToken"},
        );
        print('response of onLogin: ${response.body}');
      } catch (error) {
        print('error in sending post request $error');
      }
      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }
}
