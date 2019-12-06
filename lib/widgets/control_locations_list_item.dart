import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location.dart';
import 'package:shadowrun/screens/single_location_control_screen.dart';
import '../types/location_controls_arguments.dart';

class ControlLocationsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<Location>(context).locationData;
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            SingleLocationControlScreen.routeName,
            arguments: LocationControlsArguments(
              locationLabel: locationData.locationLabel,
              locationName: locationData.name,
              locationId: locationData.id,
            ),
          );
        },
        child: ListTile(
          title: Text(
            locationData.name,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Container(
            width: 20,
            alignment: Alignment.center,
            child: Icon(Icons.arrow_right),
          ),
        ));
  }
}
