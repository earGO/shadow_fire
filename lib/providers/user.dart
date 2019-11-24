import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier{
  String id;
  String name;
  String email;
  bool visible;

  User({this.id,this.name,this.visible,this.email});

  void _setVisibleToUser(bool newValue){
    visible = newValue;
    notifyListeners();
  }

  void toggleFavorite(newValue){
    _setVisibleToUser(newValue);
  }

}