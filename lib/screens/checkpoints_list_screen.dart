import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/widgets/locations_list_builder.dart';
import '../connected/firebase_auth.dart';
import '../providers/locations.dart';
import '../providers/users.dart';

class CheckpointsListScreen extends StatefulWidget {
  static String routeName = '/checkpoints-list';

  @override
  _CheckpointsListScreenState createState() => _CheckpointsListScreenState();
}

class _CheckpointsListScreenState extends State<CheckpointsListScreen> {
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
        title: Text('Чек пойнты'),
      ),
      body: LocationsListBuilder(),
    );
  }
}
