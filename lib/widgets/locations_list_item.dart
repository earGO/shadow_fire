import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/types/check_in_arguments.dart';
import '../providers/location.dart';
import '../screens/check_in_screen.dart';

class LocationsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<Location>(context).locationData;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          CheckInScreen.routeName,
          arguments: CheckInArguments(
            ssid: locationData.ssid,
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
        subtitle:
            !locationData.unlocked ? null : Text(locationData.timeToUnlock),
        trailing: Icon(Icons.directions_run),
      ),
    );
  }
}
