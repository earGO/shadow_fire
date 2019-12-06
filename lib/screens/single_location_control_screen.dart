import 'package:flutter/material.dart';
import 'package:shadowrun/types/location_controls_arguments.dart';

class SingleLocationControlScreen extends StatelessWidget {
  static String routeName = '/single-location-control';
  @override
  Widget build(BuildContext context) {
    final LocationControlsArguments arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление локацией'),
      ),
      body: Text('Экран управления локацией ${arguments.locationLabel}'),
    );
  }
}
