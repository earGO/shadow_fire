import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/providers/implant.dart';

class SingleImplant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).currentUser.getUser;
    final implant = Provider.of<Implant>(context).getImplant;
    print(implant.name);
    return user.implants.contains(implant.id)
        ? Container()
        : ListTile(
            title: Container(
                margin: EdgeInsets.only(
                  left: 8,
                ),
                child: Text(implant.name)),
            leading: Icon(
              IconData(implant.icondata, fontFamily: 'MaterialIcons'),
              size: 105,
            ),
            subtitle: Container(
              height: 105,
              width: double.infinity,
              margin: EdgeInsets.only(left: 8, right: 10, top: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    implant.description,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '\$ ${implant.price}',
                        ),
                        FlatButton(
                          child: Text('купить'),
                          onPressed:
                              user.credits >= implant.price ? () {} : null,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
