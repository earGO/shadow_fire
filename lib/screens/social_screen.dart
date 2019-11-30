import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/connected/firebase_auth.dart';
import 'package:shadowrun/screens/visibility_control_screen.dart';
import 'package:shadowrun/widgets/set_communicate.dart';
import 'package:shadowrun/widgets/set_hammered.dart';
import 'package:shadowrun/widgets/visibility_switch.dart';
import 'package:shadowrun/widgets/who_and_where_list.dart';
import 'package:shadowrun/providers/users.dart';

class SocialScreen extends StatefulWidget {
  static String routeName = '/status-and-visibility';
  SocialScreen({Key key}) : super(key: key);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  var _isInit = true;
  var _isLoading = false;
  String currentToken;

  @override
  void didChangeDependencies() {
    final currentUserToken = Provider.of<AuthProvider>(context).token;
    final currentUser = Provider.of<Users>(context).currentUser;
    currentToken = currentUserToken;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context)
          .fetchVisibleUsers(
              token: currentUserToken, currentUserId: currentUser.uid)
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
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Хочу'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                SetCommunicate(),
                SetHammered(),
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
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 8,
                    bottom: 12,
                  ),
                  child: Text(
                    'Кто гдe',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: WhoAndWhereList(),
                ),
              ],
            ),
          );
  }
}
