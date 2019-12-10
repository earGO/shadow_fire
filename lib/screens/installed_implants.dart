import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/implants.dart';
import 'package:shadowrun/providers/implant.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/connected/firebase_auth.dart';
import 'package:shadowrun/widgets/installed_implant.dart';
import 'package:shadowrun/screens/main_screen.dart';

class InstalledImplants extends StatefulWidget {
  static String routeName = '/installed-implants';

  @override
  _InstalledImplantsState createState() => _InstalledImplantsState();
}

class _InstalledImplantsState extends State<InstalledImplants> {

  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final currentUserToken = Provider.of<AuthProvider>(context).token;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Implants>(context,listen: false)
          .fetchAndSetAllImplants(token: currentUserToken)
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

    List<Implant> installedImplants( List<Implant> implants,List<dynamic> userImplants){
      List<Implant> result = [];
      implants.forEach((implant){
        if(userImplants.contains(implant.id)){
          result.add(implant);
        }
      });
      return result;
    }

    final user = Provider.of<Users>(context).currentUser.getUser;
    final implants = Provider.of<Implants>(context).implants;
    final userImplants = user.implants;
    final userInstalledImplants = installedImplants(implants,userImplants);
    return Scaffold(
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
        title: Text('Импланты'),
      ),
      body: userImplants.length>0? Center(
        child:  ListView.separated(
          separatorBuilder: (context,index)=>Divider(
            color: Theme.of(context).primaryColorLight,
          ),
          itemCount: userInstalledImplants.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: userInstalledImplants[index],
            child: InstalledImplant(),
          ),
        ),
      ) : Center(
        child: Text('Не установлено никаких имплантов. Посетите магазин!'),
      ),
    );
  }
}
