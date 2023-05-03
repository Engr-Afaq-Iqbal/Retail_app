import 'package:flutter/material.dart';

class TableInfo extends StatelessWidget {
  final String? tableName;
  const TableInfo(this.tableName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.table_restaurant_outlined, size: 15),
        SizedBox(width: 5),
        Flexible(
          child: Text(
            tableName ?? '-',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}
