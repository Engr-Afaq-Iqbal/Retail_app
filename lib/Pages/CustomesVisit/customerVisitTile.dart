import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Controllers/CustomerVisits/CustomerVisitsController.dart';
import '../../Theme/style.dart';
import 'Update Status/updateStatus.dart';
import 'createCustomerVisit.dart';

class CustomerVisitTile extends StatefulWidget {
  int index;
  CustomerVisitsController customerVisitsCtrlObj;
  CustomerVisitTile(
      {Key? key, required this.index, required this.customerVisitsCtrlObj})
      : super(key: key);

  @override
  State<CustomerVisitTile> createState() => _CustomerVisitTileState();
}

class _CustomerVisitTileState extends State<CustomerVisitTile> {
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
              height: 35,
              width: 140,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (viewStocksModel?.transactionDate != null)
                  Text(
                    widget.customerVisitsCtrlObj.customerVisitsListModel
                            ?.data[widget.index].status.capitalizeFirst ??
                        '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: orangeColor
                        // viewStocksModel?.transactionDate !=
                        //         null
                        //     ? Colors.white
                        //     : Colors.black,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1:
                            'Visit ID: ${widget.customerVisitsCtrlObj.customerVisitsListModel?.data[widget.index].id ?? ''}',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Checked In: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 11.7),
                        text2: widget
                                .customerVisitsCtrlObj
                                .customerVisitsListModel
                                ?.data[widget.index]
                                .visitedOn ??
                            '- -',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: orangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.7,
                              letterSpacing: 0.06,
                            ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 12,
                          width: 1,
                          color: Colors.black),
                      orderInfoRow(
                        context,
                        text1: 'Contact: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 11.7),
                        text2: widget
                                .customerVisitsCtrlObj
                                .customerVisitsListModel
                                ?.data[widget.index]
                                .contactId
                                .toString() ??
                            '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: orangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.7,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Assigned to: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12),
                        text2: 'Mr Super Admin',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: orangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Address: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12),
                        text2: widget
                                .customerVisitsCtrlObj
                                .customerVisitsListModel
                                ?.data[widget.index]
                                .visitingAddress ??
                            '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(
                        leading: Icon(
                          Icons.edit_outlined,
                          color: kWhiteColor,
                          size: 25,
                        ),
                        title: Text(
                          '',
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return GetBuilder<StockTransferController>(
                                  builder: (StockTransferController
                                      stockTransferCtrlObj) {
                                return Container(
                                  child: CreateCustomerVisits(),
                                );
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                        leading: Icon(
                          Icons.delete_outlined,
                          color: kWhiteColor,
                          size: 25,
                        ),
                        title: Text(
                          '',
                        ),
                        onTap: () {
                          AppStyles.deleteConfirmationDialog(confirmBtnAct: () {
                            widget.customerVisitsCtrlObj
                                .deleteCustomerVisitsList(
                                    id: widget
                                        .customerVisitsCtrlObj
                                        .customerVisitsListModel
                                        ?.data[widget.index]
                                        .id
                                        .toString());
                            widget.customerVisitsCtrlObj.update();
                          });
                        },
                        bgColor: buttonColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                        leading: Icon(
                          Icons.edit_note_outlined,
                          color: kWhiteColor,
                          size: 25,
                        ),
                        title: Text(
                          '',
                        ),
                        onTap: () {
                          Get.to(UpdateStatus());
                        },
                        bgColor: orangeColor.withOpacity(0.9),
                      ),
                    ],
                  )
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
