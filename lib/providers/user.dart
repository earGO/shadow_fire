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
}
