import 'package:flutter/material.dart';
import 'package:shadowrun/screens/status_and_visibility.dart';

import '../screens/status_and_visibility.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(-24.0, 0.0, 0.0),
                    decoration: BoxDecoration(),
                    child: ListTile(
                      leading: CircleAvatar(
                        minRadius: 24.0,
                        maxRadius: 40.0,
                        foregroundColor: Theme.of(context).primaryColorDark,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      'iv.ivanov@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Обзор профиля'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.mood),
            title: Text('Бежать маршрут'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Видимость/Статус'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.of(context).pushNamed(StatusAndVisibility.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Магазин имплантов'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Выход'),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
