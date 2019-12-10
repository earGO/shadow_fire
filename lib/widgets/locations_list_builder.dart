import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locations.dart';
import '../widgets/locations_list_item.dart';

class LocationsListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationsData = Provider.of<Locations>(context).locations;
    return ListView.separated(
      separatorBuilder: (context,index)=>Divider(
        color: Theme.of(context).primaryColorLight,
      ),
      itemCount: locationsData.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: locationsData[index],
        child: LocationsListItem(),
      ),
    );
  }
}
