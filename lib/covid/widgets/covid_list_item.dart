import 'package:flutter/material.dart';
import 'package:flutter_covid_bloc/covid/models/covid.dart';
class CovidListItem extends StatelessWidget {
  const CovidListItem({Key? key, required this.covid}): super(key:key);
  final Covid covid;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final textTheme = Theme.of(context).textTheme;

    return Material(
      child: ListTile(
        leading: Text('${covid.id}', style: textTheme.caption),
        title: Text(covid.country),
        subtitle: Text('${covid.confirmed}'),
        isThreeLine: true,
        dense: true,
        // subtitle: Text('${covid.confirmed}'),
      ),
    );
    throw UnimplementedError();
  }

}