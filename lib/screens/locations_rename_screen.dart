import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/widgets/control_locations_list_builder.dart';
import 'package:shadowrun/widgets/locations_list_builder.dart';
import '../connected/firebase_auth.dart';
import '../providers/locations.dart';
import '../providers/users.dart';

class LocationsRenameScreen extends StatefulWidget {
  static String routeName = '/locations-rename';

  @override
  _LocationsRenameScreenState createState() => _LocationsRenameScreenState();
}

class _LocationsRenameScreenState extends State<LocationsRenameScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final currentUserToken = Provider.of<AuthProvider>(context).token;
    final userId = Provider.of<Users>(context).currentUser.getUser.uid;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Locations>(context,listen: false)
          .fetchAndSetAllLocations(token: currentUserToken,userId:userId )
          .then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление локациями'),
      ),
      body: Center(
        child: ControlLocationsListBuilder(),
      ),
    );
  }
}
