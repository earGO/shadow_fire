import 'package:flutter/material.dart';
import 'package:shadowrun/widgets/visibility_list_control_item_show_all.dart';
import 'package:shadowrun/widgets/visibility_list_control_items.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class VisibilityListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context).users;
    return Container(
      child:  Column(
          children: <Widget>[
            VisibilityListControlItemShowAll(),
      Expanded(
          child:ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: userData[index],
              child: VisibilityListControlItems(),
            ),
          ),),]

      ),
    );
  }
}
