import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String name;
  String email;
  bool visible;
  String uid;
  bool wannaHammered;
  bool wantToCommunicate;
  bool firstTime;
  String avatar;
  num credits;

  User({
    @required this.name,
    @required this.visible,
    @required this.email,
    @required this.uid,
    @required this.avatar,
    @required this.wannaHammered,
    @required this.wantToCommunicate,
    @required this.firstTime,
    @required this.credits,
  });

  get getUser {
    return this;
  }

  void _setVisibleToUser(bool newValue) {
    visible = newValue;
    notifyListeners();
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      name: parsedJson['user']['name'],
      email: parsedJson['user']['email'],
      visible: parsedJson['user']['visible'],
      uid: parsedJson['user']['uid'],
      avatar: parsedJson['user']['avatar'],
      wannaHammered: parsedJson['user']['wannaHammered'],
      wantToCommunicate: parsedJson['user']['wantToCommunicate'],
      firstTime: parsedJson['user']['firstTime'],
      credits: parsedJson['user']['credits'],
    );
  }

  void toggleFavorite(newValue) {
    _setVisibleToUser(newValue);
  }

  Future<void> toggleFavoriteStatus({String token, String arrayId,String ownerId}) async {
    // here arrayID is the ID of a user we want to be visible to
    //ownerId is the ID of a user,logged into and app;
    final oldStatus = visible;
    visible = !visible;
    notifyListeners();
    if(visible==true){
      final url =
          'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/addToVisible';
      try {
        final response = await http.post(
          url,
          body: json.encode({
           'ownerId':ownerId,
            'arrayId':arrayId
          }),
        );
        if (json.decode(response.body).message != 'good') {
          _setVisibleToUser(oldStatus);
        }
      } catch (error) {
        _setVisibleToUser(oldStatus);
      }
    } else {
      final url =
          'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/removeFromVisible';
      try {
        final response = await http.post(
          url,
          body: json.encode({
            'ownerId':ownerId,
            'arrayId':arrayId
          }),
        );
        if (json.decode(response.body).message != 'good') {
          _setVisibleToUser(oldStatus);
        }
      } catch (error) {
        _setVisibleToUser(oldStatus);
      }
    }

  }

}
