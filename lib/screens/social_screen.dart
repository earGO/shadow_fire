import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/connected/firebase_auth.dart';
import 'package:shadowrun/screens/visibility_control_screen.dart';
import 'package:shadowrun/widgets/visibility_switch.dart';
import '../providers/users.dart';

class SocialScreen extends StatefulWidget {
  static String routeName = '/status-and-visibility';
  SocialScreen({Key key}) : super(key: key);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  bool _wantToCommunicate = false;
  bool _wantToGetHammered = false;

  void handleCommunicate(val) {
    setState(() {
      _wantToCommunicate = val;
    });
  }

  void handleHammered(val) {
    setState(() {
      _wantToGetHammered = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Users>(context).currentUser;
    print(currentUser);
    return Scaffold(
      appBar: AppBar(
        title: Text('Хочу'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          VisibilitySwitch(
            title: 'Общения',
            value: _wantToCommunicate,
            switchHandler: handleCommunicate,
          ),
          VisibilitySwitch(
            title: 'Огня',
            value: _wantToGetHammered,
            switchHandler: handleHammered,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(VisibilityControlScreen.routeName);
            },
            child: ListTile(
              title: Text('Кто меня видит'),
              trailing: Icon(
                IconData(
                  58133,
                  fontFamily: 'MaterialIcons',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
