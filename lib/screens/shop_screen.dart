import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/implants.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/connected/firebase_auth.dart';
import 'package:shadowrun/widgets/single_implant.dart';

class Shop extends StatefulWidget {
  static String routeName='/implants-shop';

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
    final implants = Provider.of<Implants>(context).implants;
    return Scaffold(
      appBar: AppBar(
        title: Text('Магазин имплантов'),
      ),
      body: _isLoading ? Center(
        child: Text('Загрузка имплантов'),
      ) :Center(
        child: ListView.separated(
          separatorBuilder: (context,index)=>Divider(
            color: Theme.of(context).primaryColorLight,
          ),
          itemCount: implants.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: implants[index],
            child: SingleImplant(),
          ),
        ),
      )
    );
  }
}
