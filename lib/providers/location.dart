import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Location with ChangeNotifier {
  String name;
  String id;
  String ssid;
  num lastCheckIn;
  String locationLabel;

  Location({this.name,  this.lastCheckIn, this.id, this.ssid,this.locationLabel});

  get locationData {
    return this;
  }

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
      name: parsedJson['label'],
      id: parsedJson['locationId'],
      ssid: parsedJson['ssid'],
      lastCheckIn: parsedJson['lastCheckIn'],
        locationLabel:parsedJson['label']
    );
  }
}
