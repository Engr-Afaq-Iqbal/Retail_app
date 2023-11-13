import 'package:flutter/material.dart';

import '../../../Components/bodyHeadingTile.dart';

class AllProposalsTile extends StatelessWidget {
  AllProposalsTile({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BodyHeadingTile(
                heading: 'Contact:',
                body: 'Walk-In',
              ),

              Text(
                '13/11/2023 11:48',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          BodyHeadingTile(
            heading: 'Subject:',
            body: 'testing',
          ),
          BodyHeadingTile(
            heading: 'Sent by:',
            body: 'Haseeb Bin Umer',
          ),

          // AppConst.dividerLine(height: 12, width: 1),
        ],
      ),
    );
  }
}
