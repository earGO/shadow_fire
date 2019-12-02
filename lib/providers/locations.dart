import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './location.dart';

class Locations with ChangeNotifier {
  List<Location> _locations = [];
  Location _currentLocation;

  List<Location> get locations {
    return [..._locations];
  }

  Location get currentLocation{
    return _currentLocation;
  }

  void _setCurrentLocation(Location newLocation){
    _currentLocation = newLocation;
    notifyListeners();
  }

  Future<void> fetchAndSetAllLocations({String token}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getAllLocations';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = json.decode(response.body)['locations'];
      if (extractedData == null) {
        return;
      }
      final List<Location> loadedLocations = [];
      extractedData.forEach((locationData) {
        loadedLocations.add(Location(
          name: locationData['label'],
          id: locationData['locationId'],
          ssid: locationData['ssid'],
          unlocked: false,
          timeToUnlock: DateTime.now().add(
            Duration(seconds: 3600),
          ),
        ));
      });
      _locations=loadedLocations;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkUserIn({String token,String userId,String locationId}) async {
    final oldLocation = _currentLocation;
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/checkMeIn';
    final locationUrl =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getLocationById';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'userId':userId,
          'locationId':locationId,
        }),
        headers: {'Authorization': "Bearer $token"},
      );
      final responseData = await json.decode(response.body) as Map<String,dynamic>;
      final responseMessage = responseData['message'];
      //now let's fetch new current location
      final locationResponse = await http.post(
        locationUrl,
        body: json.encode({
          'locationId':locationId,
        }),
        headers: {'Authorization': "Bearer $token"},
      );
      final locationResponseData = await json.decode(locationResponse.body) as Map<String,dynamic>;
      final locationResponseMessage = locationResponseData['message'];
      final locationData = Location.fromJson(locationResponseData['location']);
      _setCurrentLocation(locationData);
      if (responseMessage != 'good' && locationResponseMessage!='good') {
        _setCurrentLocation(oldLocation);
      }
    } catch (error) {
      _setCurrentLocation(oldLocation);
    }
  }
}
