import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/types/check_in_arguments.dart';
import '../providers/location.dart';
import '../screens/check_in_screen.dart';

class LocationsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<Location>(context).locationData;
    final timerDate = locationData.lastCheckIn;
    final now = DateTime
        .now()
        .millisecondsSinceEpoch;
    return ListTile(
        title: Text(
          locationData.name,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w500,
          ),
        ),
          trailing: (timerDate - now) >36000 ? Container(
              width: 20,
              alignment: Alignment.center,
              child:InkWell(
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
                child: Icon(Icons.arrow_right),) ,):
        StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1), (i) => i),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              DateFormat format = DateFormat("mm:ss");
              var streamedNow = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              Duration remaining = Duration(milliseconds: timerDate - streamedNow);
              var dateString = '${remaining.inHours}:${format.format(
                  DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
              return Container(
                width: 80,
                alignment: Alignment.center,
                child: Text('$dateString'),);
            }),

    );
  }
}
