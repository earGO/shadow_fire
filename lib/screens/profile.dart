import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: Text('Profile screen'),
      ),
      drawer: AppDrawer(),
    );
  }
}
