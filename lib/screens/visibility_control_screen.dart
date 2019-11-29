import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context)
          .fetchAndSetAllUsers(token: currentUserToken)
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
    final usersData = Provider.of<Users>(context).users;
    return Scaffold(
      appBar: AppBar(
        title: Text('Кто меня видит'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: usersData.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: usersData[index],
            child: VisibilityListControlItems(),
          ),
        ),
      ),
    );
  }
}
