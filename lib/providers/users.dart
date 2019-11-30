import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  List<User> _visibleUsers=[];
  User _currentUser;

  List<User> get users {
    return [..._users];
  }

  List<User> get visibleUsers {
    return [..._visibleUsers];
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

  Future<void> fetchAndSetAllUsers({String token, String ownerId}) async {
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
      final visibleUrl = 'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getVisibilityArray';
      final visibleResponse = await http.post(
        visibleUrl,
        body: json.encode({
          'ownerId':ownerId
        }),
        headers: {'Authorization': "Bearer $token"},
      );
      final visibleData = json.decode(visibleResponse.body) as Map<String, dynamic>;
      final visibleArray = visibleData['visibility'];
      print(visibleArray.contains(ownerId));
      print(ownerId);
      final List<User> loadedUsers=[];
      extractedData.forEach((userData) {
        loadedUsers.add(User(
          uid: userData['uid'],
          avatar: userData['avatar'],
          name: userData['name'],
          email: userData['email'],
          credits: userData['credits'],
          visible: visibleArray == null? false :
            visibleArray.contains(userData['uid']),
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

  Future<void> fetchVisibleUsers({String token, String currentUserId}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getVisibleUsers';
    try {
      final response = await http.post(
        url,
        body: json.encode( {
          'userId':currentUserId
        }),
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = json.decode(response.body)['users'];
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
            visible: true,
            wannaHammered: userData['wantToBeHammered'],
            wantToCommunicate: userData['wantToCommunicate']

        ));
      });
      _visibleUsers = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
}
}
