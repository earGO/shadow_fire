import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FirstTime extends StatefulWidget {
  final String username;//if you have multiple values add here
  FirstTime(this.username, {Key key}): super(key: key);//add also..example this.abc,this...

  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
