import 'package:flutter/material.dart';

import '../../../../Components/bodyHeadingTile.dart';

class BrandsTile extends StatefulWidget {
  BrandsTile(
      {Key? key,})
      : super(key: key);

  @override
  State<BrandsTile> createState() => _BrandsTileState();
}

class _BrandsTileState extends State<BrandsTile> {
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
                  heading: 'Brands:',
                  body: 'test',
                ),

                BodyHeadingTile(
                  heading: 'Note:',
                  body: 'testting',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.edit_outlined, size: 20,color: Theme.of(context).primaryColor,),
              SizedBox(width: 10,),
              Icon(Icons.delete_outline_outlined, size: 20, color: Theme.of(context).primaryColor,)
            ],
          )
        ],
      ),
    );
  }
}
