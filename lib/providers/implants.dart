import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './implant.dart';

class Implants with ChangeNotifier {
  List<Implant> _implants = [];
  List<Implant> _installedImplants = [];

  List<Implant> get implants {
    return [..._implants];
  }

  List<Implant> get installedImplants {
    return [..._installedImplants];
  }

  Future<void> fetchAndSetAllImplants({String token}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getAllImplants';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = json.decode(response.body)['implants'];
      if (extractedData == null) {
        return;
      }
      final List<Implant> loadedImplants = [];
      extractedData.forEach((locationData) {
        print('fetched implant $locationData');
        loadedImplants.add(new Implant.fromJson(locationData));
      });
      _implants = loadedImplants;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> buyImplant({String token, String userId, String implantId}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/buyImplant';
    try {
      final response = await http.post(
        url,
        body:json.encode({
          'userId':userId,
          'implantId':implantId        }),
        headers: {'Authorization': "Bearer $token"},
      );

      final extractedData = await json.decode(response.body)['message'];
      print(extractedData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
