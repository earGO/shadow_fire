import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shadowrun/widgets/visibility_list_builder.dart';
import 'package:shadowrun/widgets/visibility_list_control_items.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class VisibilityControlScreen extends StatefulWidget {
  static String routeName = '/VisibilityControlScreen';

  @override
  _VisibilityControlScreenState createState() =>
      _VisibilityControlScreenState();
}

class _VisibilityControlScreenState extends State<VisibilityControlScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final currentUserToken = Provider.of<AuthProvider>(context).token;
    final currentUser = Provider.of<Users>(context).currentUser;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context)
          .fetchAndSetAllUsers(token: currentUserToken,ownerId: currentUser.uid)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кто меня видит'),
      ),
      body: Center(
        child:VisibilityListBuilder()
      ),
    );
  }
}
