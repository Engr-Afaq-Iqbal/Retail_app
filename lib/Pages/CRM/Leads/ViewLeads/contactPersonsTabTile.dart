import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/bodyHeadingTile.dart';
import '../../../../Config/DateTimeFormat.dart';


class ContactPersonsTabTile extends StatefulWidget {
  ContactPersonsTabTile(
      {Key? key,})
      : super(key: key);

  @override
  State<ContactPersonsTabTile> createState() => _ContactPersonsTabTileState();
}

class _ContactPersonsTabTileState extends State<ContactPersonsTabTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 100,
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      child: Row(
        children: [
          // RotatedBox(
          //   quarterTurns: -1,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10),
          //     height: 30,
          //     // width: 140,
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          //       borderRadius: BorderRadius.only(
          //         bottomRight: Radius.circular(10),
          //         bottomLeft: Radius.circular(10),
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // if (viewStocksModel?.transactionDate != null)
          //         Text('scheduled',
          //           style: Theme.of(context).textTheme.bodySmall!.copyWith(
          //               fontSize: 11.7,
          //               fontWeight: FontWeight.bold,
          //               color: orangeColor
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyHeadingTile(
                        heading: 'Username:',
                        body: 'test',
                      ),
                      BodyHeadingTile(
                        heading: 'Name:',
                        body: 'Mr Afaq Iqbal',
                      ),
                    ],
                  ),
                  BodyHeadingTile(
                    heading: 'Email:',
                    body: 'afaqiqbal1845@gmail.com',
                  ),

                  BodyHeadingTile(
                    heading: 'Department:',
                    body: 'testing',
                  ),

                  BodyHeadingTile(
                    heading: 'Designation:',
                    body: 'testing',
                  ),

                  // Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderInfoRow(BuildContext context,
      {String? text1,
        TextStyle? text1Style,
        Widget? text1Overwrite,
        String? text2,
        TextStyle? text2Style,
        Widget? text2Overwrite,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          text1Overwrite ??
              Text(
                text1 ?? '',
                style: text1Style ??
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
          text2Overwrite ??
              Text(
                (text2 != null && text2.isNotEmpty) ? text2.capitalize! : '',
                style: text2Style ??
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
        ],
      ),
    );
  }
}
