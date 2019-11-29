import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  User _currentUser;

  List<User> get users {
    return [..._users];
  }

  List<User> findByName(String name) {
    return name == '' || name == null
        ? [..._users]
        : _users
            .where(
                (user) => user.name.toLowerCase().contains(name.toLowerCase()))
            .toList();
  }

  User get currentUser {
    return _currentUser;
  }

  Future<void> fetchAndSetUser({String uid, String token}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/fetchUser';
    final response = await http.post(
      url,
      body: json.encode(
        {'uid': uid},
      ),
      headers: {'Authorization': "Bearer $token"},
    );
    final decoded = await json.decode(response.body);
    _currentUser = new User.fromJson(decoded);
    notifyListeners();
  }

  Future<void> fetchAndSetAllUsers({String token}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getAllUsers';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer $token"},
      );
      final extractedData =
           json.decode(response.body)['users'];
      if (extractedData == null) {
        return;
      }
      final List<User> loadedUsers=[];
      extractedData.forEach((userData) {
        loadedUsers.add(User(
          uid: userData['uid'],
          avatar: userData['avatar'],
          name: userData['name'],
          email: userData['email'],
          credits: userData['credits'],
          visible: userData['visible'],
          wannaHammered: userData['wantToBeHammered'],
          wantToCommunicate: userData['wantToCommunicate']

        ));
      });
      _users = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
