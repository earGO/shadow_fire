import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Location with ChangeNotifier {
  String name;
  String id;
  String ssid;
  bool unlocked;
  DateTime timeToUnlock;

  Location({this.name, this.unlocked, this.timeToUnlock, this.id, this.ssid});

  get locationData {
    return this;
  }

  void _toggleUnocked(bool newStatus) {
    unlocked = newStatus;
    notifyListeners();
  }

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
      name: parsedJson['label'],
      id: parsedJson['locationId'],
      ssid: parsedJson['ssid'],
      unlocked: false,
      timeToUnlock: DateTime.now().add(
        Duration(seconds: 3600),
      ),
    );
  }
}
