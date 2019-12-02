import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import '../providers/locations.dart';
import '../connected/firebase_auth.dart';
import '../providers/users.dart';

class CheckInDialogue extends StatelessWidget {
  final List<BluetoothDiscoveryResult> devices;
  final String neededSsid;
  final String locationName;
  final String locationId;

  CheckInDialogue({this.devices, this.neededSsid, this.locationName,this.locationId});

  bool _deviceInSight() {
    var result = false;
    devices.forEach((device) {
      if (device.device.address == neededSsid) result = true;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final token = Provider.of<AuthProvider>(context).token;
    final userId = Provider.of<Users>(context).currentUser.getUser.uid;
    return Center(
      child: _deviceInSight()
          ? Card(
              color: Colors.white,
              child: Container(
                width: screenWidth * 0.88,
                height: screenHeight * .28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        locationName,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Text('CHECK IN',style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 16,
                        ),),
                        onPressed: () {
                          Provider.of<Locations>(context,listen: false).checkUserIn(
                            token: token,
                            userId: userId,
                            locationId: locationId,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          : Text(
              'Вы не в выбранной комнате',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
    );
  }
}