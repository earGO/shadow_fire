import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import 'who_and_where_item.dart';

class WhoAndWhereList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final visibleUsers = Provider.of<Users>(context,listen: false).visibleUsers;
    return ListView.builder(
      itemCount: visibleUsers.length,
      itemBuilder: (ctx, index) => WhoAndWhereItem(visibleUsers[index]),
    );
  }
}
