import 'package:flutter/material.dart';

import '../widgets/visibility_screen_widgets/visibility_switch.dart';
import './visibility_list.dart';

class StatusAndVisibility extends StatefulWidget {
  static String routeName = '/status-and-visibility';

  @override
  _StatusAndVisibilityState createState() => _StatusAndVisibilityState();
}

class _StatusAndVisibilityState extends State<StatusAndVisibility> {
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
            title: 'Алкогольной ямы',
            value: _wantToGetHammered,
            switchHandler: handleHammered,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(VisibilityList.routeName);
            },
          )
        ],
      ),
    );
  }
}
