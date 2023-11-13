import 'package:flutter/material.dart';

import '../../../Components/bodyHeadingTile.dart';


class CommissionsTile extends StatelessWidget {
  CommissionsTile({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodyHeadingTile(
                  heading: 'Invoice:',
                  body: 'INV101',
                ),
                Text(
                  '10/11/2023',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                ),

              ],
            ),
            // SizedBox(height: 5,),
            BodyHeadingTile(
              heading: 'Name:',
              body: 'Afaq Iqbal',
            ),
            BodyHeadingTile(
              heading: 'Mobile No:',
              body: '+924568876556',
            ),
            BodyHeadingTile(
              heading: 'Location:',
              body: 'Restaurant',
            ),
            BodyHeadingTile(
              heading: 'Total Commission:',
              body: '0.00',
            ),
            // AppConst.dividerLine(height: 12, width: 1),
          ],
        ),
      ),
    );
  }
}
