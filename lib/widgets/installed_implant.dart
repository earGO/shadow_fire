import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/implant.dart';

class InstalledImplant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final implant = Provider.of<Implant>(context).getImplant;
    return ListTile(
      title: Container(
          margin: EdgeInsets.only(
            left: 8,
          ),
          child: Text(implant.name)),
      leading: Icon(
        IconData(implant.icondata, fontFamily: 'MaterialIcons'),
        size: 90,
      ),
      subtitle: Container(
        height: 80,
        width: double.infinity,
        margin: EdgeInsets.only(left: 8, right: 10, top: 3),
        child:
            Text(
              implant.description,
              style: TextStyle(
                fontSize: 12,
              ),
            ),

      ),
    );
  }
}
