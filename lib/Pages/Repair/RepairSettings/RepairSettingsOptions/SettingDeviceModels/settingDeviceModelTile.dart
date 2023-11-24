import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../Components/bodyHeadingTile.dart';

class SettingDeviceModelsTile extends StatefulWidget {
  SettingDeviceModelsTile(
      {Key? key,})
      : super(key: key);

  @override
  State<SettingDeviceModelsTile> createState() => _SettingDeviceModelsTileState();
}

class _SettingDeviceModelsTileState extends State<SettingDeviceModelsTile> {
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
                  heading: 'Model Name:',
                  body: 'test',
                ),

                BodyHeadingTile(
                  heading: 'Repair Checklist:',
                  body: 'test',
                ),
                BodyHeadingTile(
                  heading: 'Device:',
                  body: 'test',
                ), BodyHeadingTile(
                  heading: 'Brand:',
                  body: 'test',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.edit_outlined, size: 20,color: Theme.of(context).primaryColor,),
              SizedBox(width: 10,),
              Icon(Icons.delete_outline_outlined, size: 20, color: buttonColor,)
            ],
          )
        ],
      ),
    );
  }
}
