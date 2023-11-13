import 'package:flutter/material.dart';

import '../../../Components/bodyHeadingTile.dart';

class AllSourceTile extends StatelessWidget {
  AllSourceTile({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyHeadingTile(
                heading: 'Source:',
                body: 'testing',
              ),
              BodyHeadingTile(
                heading: 'Description:',
                body: 'Haseeb Bin Umer',
              ),
              SizedBox(height: 10,),
              // AppConst.dividerLine(height: 12, width: 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.edit_outlined,color: Theme.of(context).primaryColor,size: 20,),
              SizedBox(width: 10,),
              Icon(Icons.delete,color: Theme.of(context).primaryColor,size: 20,),
            ],
          )
        ],
      ),
    );
  }
}
