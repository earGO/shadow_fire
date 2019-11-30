import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  List<User> _visibleUsers = [];
  User _currentUser;
  bool _currentHammered;
  bool _currentCommunicate;

  List<User> get users {
    return [..._users];
  }

  bool get currentHammered{
    return _currentHammered;
  }

  bool get currentCommunicate{
    return _currentCommunicate;
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

  void _setCurrentHammered(bool newValue){
    _currentHammered = newValue;
    notifyListeners();
}
  void _setCurrentCommunicate(bool newValue){
    _currentCommunicate = newValue;
    notifyListeners();
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
    final workUser = new User.fromJson(decoded);
    _currentUser = workUser;
    _setCurrentHammered(workUser.getUser.wantHammered);
    _setCurrentCommunicate(workUser.getUser.wantToCommunicate);
    notifyListeners();
  }

  Future<void> fetchAndSetAllUsers({String token, String ownerId}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getAllUsers';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'userId':_currentUser.getUser.uid
        }),
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = json.decode(response.body)['users'];
      if (extractedData == null) {
        return;
      }
      final visibleUrl =
          'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getVisibilityArray';
      final visibleResponse = await http.post(
        visibleUrl,
        body: json.encode({'ownerId': ownerId}),
        headers: {'Authorization': "Bearer $token"},
      );
      final visibleData =
          json.decode(visibleResponse.body) as Map<String, dynamic>;
      final visibleArray = visibleData['visibility'];
      print(visibleArray.contains(ownerId));
      print(ownerId);
      final List<User> loadedUsers = [];
      extractedData.forEach((userData) {
        loadedUsers.add(User(
            uid: userData['uid'],
            avatar: userData['avatar'],
            name: userData['name'],
            email: userData['email'],
            credits: userData['credits'],
            visible: visibleArray == null
                ? false
                : visibleArray.contains(userData['uid']),
            wantToBeHammered: userData['wantToBeHammered'],
            wantToCommunicate: userData['wantToCommunicate']));
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
        body: json.encode({'userId': currentUserId}),
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = json.decode(response.body)['users'];
      if (extractedData == null) {
        return;
      }
      final List<User> loadedUsers = [];
      extractedData.forEach((userData) {
        loadedUsers.add(User(
            uid: userData['uid'],
            avatar: userData['avatar'],
            name: userData['name'],
            email: userData['email'],
            credits: userData['credits'],
            visible: true,
            wantToBeHammered: userData['wantToBeHammered'],
            wantToCommunicate: userData['wantToCommunicate']));
      });
      _visibleUsers = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> toggleCurrentUserHammered({String token}) async {
    final oldHammered = currentHammered;
    _setCurrentHammered(!currentHammered);
      final url =
          'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/toggleHammered';
      try {
        final response = await http.post(
          url,
          body: json.encode({
            'userId':_currentUser.uid,
          }),
          headers: {'Authorization': "Bearer $token"},
        );
        final responseData = await json.decode(response.body) as Map<String,dynamic>;
        final responseMessage = responseData['message'];
        if (responseMessage != 'good') {
          _setCurrentHammered(oldHammered);
        }
      } catch (error) {
        _setCurrentHammered(oldHammered);
      }

  }

  Future<void> toggleCurrentUserCommunicate({String token}) async {
    final oldCommunicate = currentCommunicate;
    _setCurrentCommunicate(!currentCommunicate);
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/toggleCommunicate';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'userId':_currentUser.uid,
        }),
        headers: {'Authorization': "Bearer $token"},
      );
      final responseData = await json.decode(response.body) as Map<String,dynamic>;
      final responseMessage = responseData['message'];
      if (responseMessage != 'good') {
        _setCurrentCommunicate(oldCommunicate);
      }
    } catch (error) {
      _setCurrentCommunicate(oldCommunicate);
    }

  }
}
