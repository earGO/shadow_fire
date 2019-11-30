import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/widgets/main_screen_controls.dart';

import '../connected/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uid = Provider.of<AuthProvider>(context).userId;
    final token = Provider.of<AuthProvider>(context).token;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context, listen: false)
          .fetchAndSetUser(uid: uid, token: token)
          .then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MainScreenControls(),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
