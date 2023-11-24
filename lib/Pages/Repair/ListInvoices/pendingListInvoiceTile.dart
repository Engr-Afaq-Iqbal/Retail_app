import 'package:flutter/material.dart';

import '../../../../Components/bodyHeadingTile.dart';
import '../../../../Config/DateTimeFormat.dart';
import '../../../../Theme/colors.dart';


class PendingListInvoiceTile extends StatefulWidget {
  final String? status;
  PendingListInvoiceTile(
      {Key? key, this.status})
      : super(key: key);

  @override
  State<PendingListInvoiceTile> createState() => _PendingListInvoiceTileState();
}

class _PendingListInvoiceTileState extends State<PendingListInvoiceTile> {
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
          RotatedBox(
            quarterTurns: -1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              // width: 140,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.status}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: orangeColor
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BodyHeadingTile(
                    heading: 'Job Sheet No:',
                    body: '2023/0001',
                  ),

                  BodyHeadingTile(
                    heading: 'Delivery Date:',
                    body: AppFormat.dateDDMMYYWithOutComma(DateTime.now()),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyHeadingTile(
                        heading: 'Service Type:',
                        body: 'Carry in',
                      ),
                      BodyHeadingTile(
                        heading: 'Technician:',
                        body: 'John',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyHeadingTile(
                        heading: 'Customer:',
                        body: 'Walk-In',
                      ),
                      BodyHeadingTile(
                        heading: 'Location:',
                        body: 'Restaurant',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyHeadingTile(
                        heading: 'Added By:',
                        body:'Haseeb Syed',
                      ),
                      BodyHeadingTile(
                        heading: 'Created At:',
                        body:AppFormat.dateDDMMYYWithOutComma(DateTime.now()),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyHeadingTile(
                        heading: 'Payment due:',
                        body: '0.00',
                      ),
                      BodyHeadingTile(
                        heading: 'Sell Return Due:',
                        body: '0.00',
                      ),
                    ],
                  ),

                  BodyHeadingTile(
                    heading: 'Total amount:',
                    body: '10.00',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
