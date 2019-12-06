import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String name;
  String email;
  bool visible;
  String uid;
  bool wantToBeHammered;
  bool wantToCommunicate;
  String avatar;
  num credits;
  String locationId;
  List<dynamic> implants;
  String lastCheckIn;
  String status;

  User({
    @required this.name,
    @required this.visible,
    @required this.email,
    @required this.uid,
    @required this.avatar,
    @required this.wantToBeHammered,
    @required this.wantToCommunicate,
    @required this.credits,
    this.locationId,
    this.implants,
    this.lastCheckIn,
    this.status,
  });

  get getUser {
    return this;
  }

  get wantHammered{
    return wantToBeHammered;
  }

  get userImplants{
    return implants;
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
      wantToBeHammered: parsedJson['user']['wantToBeHammered'],
      wantToCommunicate: parsedJson['user']['wantToCommunicate'],
      credits: parsedJson['user']['credits'],
      locationId: parsedJson['user']['currentLocationId'],
        implants:parsedJson['user']['implants'],
        lastCheckIn: parsedJson['user']['lastCheckIn'],
        status:parsedJson['user']['status'],
    );
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
        final responseData = await json.decode(response.body) as Map<String,dynamic>;
        final responseMessage = responseData['message'];
        if (responseMessage != 'good') {
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
        final responseData = await json.decode(response.body) as Map<String,dynamic>;
        final responseMessage = responseData['message'];
        if (responseMessage != 'good') {
          _setVisibleToUser(oldStatus);
        }
      } catch (error) {
        _setVisibleToUser(oldStatus);
      }
    }
  }

}
