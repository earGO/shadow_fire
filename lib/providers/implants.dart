import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './implant.dart';

class Implants with ChangeNotifier {
  List<Implant> _implants = [];

  List<Implant> get implants {
    return [..._implants];
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
}
