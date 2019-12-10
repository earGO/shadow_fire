import 'package:flutter/foundation.dart';

class Implant with ChangeNotifier {
  String id;
  String name;
  num icondata;
  num price;
  String description;
  num coeft;
  String type;

  Implant({
    @required this.coeft,
    @required this.description,
    @required this.icondata,
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.type,
  });

  get getImplant {
    return this;
  }

  factory Implant.fromJson(Map<String, dynamic> parsedJson) {
    return Implant(
      id: parsedJson['id'],
      name: parsedJson['name'],
      icondata: parsedJson['icondata'],
      price: parsedJson['price'],
      description: parsedJson['description'],
      coeft: parsedJson['coeft'],
        type:parsedJson['type'],
    );
  }
}
