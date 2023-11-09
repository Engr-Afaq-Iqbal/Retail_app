import 'package:flutter/material.dart';

import '../../../Components/bodyHeadingTile.dart';


class ContactsLoginTile extends StatelessWidget {
  ContactsLoginTile({Key? key,}) : super(key: key);

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
                  heading: 'Username:',
                  body: 'abc',
                ),
                Text(
                  'Walk-In',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
                ),

              ],
            ),
            // SizedBox(height: 5,),
            BodyHeadingTile(
              heading: 'Name:',
              body: 'Mr Afaq Iqbal',
            ),
            BodyHeadingTile(
              heading: 'Email:',
              body: 'afaqiqbal184@gmail.com',
            ),
            BodyHeadingTile(
              heading: 'Department:',
              body: 'Testing',
            ),
            BodyHeadingTile(
              heading: 'Designation:',
              body: 'Testing',
            ),
            // AppConst.dividerLine(height: 12, width: 1),
          ],
        ),
      ),
    );
  }
}
