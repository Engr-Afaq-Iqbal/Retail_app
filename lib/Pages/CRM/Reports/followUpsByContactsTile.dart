import 'package:flutter/material.dart';
import 'package:get/get.dart';



class FollowUpsByContactsTile extends StatefulWidget {
  FollowUpsByContactsTile(
      {Key? key,})
      : super(key: key);

  @override
  State<FollowUpsByContactsTile> createState() => _FollowUpsByContactsTileState();
}

class _FollowUpsByContactsTileState extends State<FollowUpsByContactsTile> {
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
                  // if (viewStocksModel?.transactionDate != null)
                  Text(
                    'Contacts',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Contacts: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        text2: 'Haseeb Bin Umer',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          orderInfoColumn(
                            context,
                            text1: 'Scheduled: ',
                            text1Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 12,
                              // fontWeight: FontWeight.bold,
                            ),
                            text2: 'Open:',
                            text2Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                            text3: 'Others:',
                            text3Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                          ),

                          SizedBox(width: 15,),
                          orderInfoColumn(
                            context,
                            text1: '0',
                            text1Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 12,  color: Color(0xffffa025),),
                            text2: '1',
                            text2Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              color: Color(0xffffa025),
                              // letterSpacing: 0.06,
                            ),
                            text3: '0',
                            text3Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              color: Color(0xffffa025),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          orderInfoColumn(
                            context,
                            text1: 'Cancelled: ',
                            text1Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 12,
                              // fontWeight: FontWeight.bold,
                            ),
                            text2: 'Completed:',
                            text2Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                              // letterSpacing: 0.06,
                            ),
                          ),

                          SizedBox(width: 15,),
                          orderInfoColumn(
                            context,
                            text1: '0',
                            text1Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 12,  color: Color(0xffffa025),),
                            text2: '0',
                            text2Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12,
                              color: Color(0xffffa025),
                              // letterSpacing: 0.06,
                            ),
                          ),
                          SizedBox(width: 25,),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                  Text(
                    'Total follow ups: 1',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 12),
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

  Widget orderInfoColumn(BuildContext context,
      {String? text1,
        TextStyle? text1Style,
        Widget? text1Overwrite,
        String? text2,
        TextStyle? text2Style,
        Widget? text2Overwrite,
        String? text3,
        TextStyle? text3Style,
        Widget? text3Overwrite,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          text3Overwrite ??
              Text(
                (text3 != null && text3.isNotEmpty) ? text3.capitalize! : '',
                style: text3Style ??
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
