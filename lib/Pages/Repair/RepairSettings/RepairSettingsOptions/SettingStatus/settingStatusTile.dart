import 'package:flutter/material.dart';

import '../../../../../Components/bodyHeadingTile.dart';

class SettingStatusTile extends StatefulWidget {
  SettingStatusTile(
      {Key? key,})
      : super(key: key);

  @override
  State<SettingStatusTile> createState() => _SettingStatusTileState();
}

class _SettingStatusTileState extends State<SettingStatusTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                BodyHeadingTile(
                  heading: 'Status Name:',
                  body: 'test',
                ),

                BodyHeadingTile(
                  heading: 'Color:',
                  body: '#562333',
                ),

                BodyHeadingTile(
                  heading: 'Sort Order:',
                  body: '123',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.edit_outlined, size: 20,color: Theme.of(context).primaryColor,),
              // SizedBox(width: 10,),
            ],
          )
        ],
      ),
    );
  }
}
