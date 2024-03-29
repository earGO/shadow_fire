import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/connected/firebase_auth.dart';
import 'package:shadowrun/screens/main_screen.dart';
import 'package:shadowrun/screens/visibility_control_screen.dart';
import 'package:shadowrun/widgets/how_others_see_me.dart';
import 'package:shadowrun/widgets/set_communicate.dart';
import 'package:shadowrun/widgets/set_hammered.dart';
import 'package:shadowrun/widgets/who_and_where_item.dart';
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
    final currentUser = Provider.of<Users>(context).currentUser;
    final currentCommunicate = Provider.of<Users>(context).currentCommunicate;
    final currentHammered = Provider.of<Users>(context).currentHammered;
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  const IconData(58820,
                      fontFamily: 'MaterialIcons', matchTextDirection: true),
                  color: Colors.white,
                ),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
                },
              ),
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
                Divider(),
                Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 8,
                      bottom: 12,
                    ),
                    child: Text(
                      'Как меня видят другие',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                  child: currentCommunicate
                      ? HowOthersSeeMe(user: currentUser,currentHammered: currentHammered,)
                      : Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            top: 8,
                            bottom: 12,
                          ),
                          child: Text(
                              'Вас никто не видит. Включите режим общения чтобы Вас увидели.'),
                        ),
                ),
                Divider(),
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
