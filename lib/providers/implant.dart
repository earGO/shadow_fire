import 'package:flutter/foundation.dart';

class Implant with ChangeNotifier {
  String id;
  String name;
  num icondata;
  num price;
  String description;
  num coeft;

  Implant({
    @required this.coeft,
    @required this.description,
    @required this.icondata,
    @required this.id,
    @required this.name,
    @required this.price,
  });

  get getImplant {
    return this;
  }

  factory Implant.fromJson(Map<String, dynamic> parsedJson) {
    return Implant(
      id: parsedJson['id'],
      name: parsedJson['locationId'],
      icondata: parsedJson['ssid'],
      price: parsedJson['price'],
      description: parsedJson['description'],
      coeft: parsedJson['coeft'],
    );
  }
}
