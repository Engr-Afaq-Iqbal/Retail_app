import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Controllers/CustomerVisits/CustomerVisitsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../Update Status/meetDetailsView.dart';

class ViewCustomerVisit extends StatefulWidget {
  const ViewCustomerVisit({Key? key}) : super(key: key);

  @override
  State<ViewCustomerVisit> createState() => _ViewCustomerVisitState();
}

class _ViewCustomerVisitState extends State<ViewCustomerVisit> {
  CustomerVisitsController custVisitsCtrlObj =
      Get.find<CustomerVisitsController>();
  String? statusValue;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Visit details (#2022/0001)') // headings(txt: 'Visit details (#2022/0001)'),
          ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingsWithText(heading: 'Contact:', txt: 'Jay'),
                          headingsWithText(
                              heading: 'Assigned to:', txt: 'Mr Super Admin')
                        ],
                      ),
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingsWithText(
                              heading: 'Visit On:', txt: '12/29/22 21:07'),
                          headingsWithText(
                              heading: 'Purpose of visiting:',
                              txt: 'Check Stock')
                        ],
                      ),
                      Row(
                        children: [
                          headings(txt: 'Address:'),
                          SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            title: Text(
                              'View on Map',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: kWhiteColor,
                              size: 18,
                            ),
                            height: 22,
                            borderRadius: 5,
                            onTap: () {},
                          )
                        ],
                      ),
                      Text('Gahaya'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              IntrinsicHeight(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingsWithText(
                          heading: 'Visited on:', txt: '05/11/2023 08:21'),
                      Row(
                        children: [
                          headings(txt: 'Visited address:'),
                          SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            title: Text(
                              'View on Map',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: kWhiteColor,
                              size: 18,
                            ),
                            height: 22,
                            borderRadius: 5,
                            onTap: () {},
                          )
                        ],
                      ),
                      Text('Southwest 17th Way, Christian Gardens'),
                      Row(
                        children: [
                          headings(txt: 'Status:'),
                          SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            title: Text(
                              'Met with contact',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            bgColor: newOrderColor.withOpacity(0.7),
                            height: 22,
                            borderRadius: 5,
                            onTap: () {},
                          )
                        ],
                      ),
                      headings(txt: 'Discussions with the contact:'),
                      Text('test2'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MeetDetailsView(
                isView: true,
              ),
              SizedBox(
                height: 15,
              ),
              IntrinsicHeight(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingsWithText(heading: 'Photo:', txt: ''),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            title: Text(
                              'Close',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            bgColor: buttonColor,
                            onTap: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
      softWrap: true,
      maxLines: 2,
    );
  }

  Row headingsWithText({required String heading, required String txt}) {
    return Row(
      children: [
        Text(
          heading,
          style: appBarHeaderStyle,
          softWrap: true,
          maxLines: 2,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          txt,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          softWrap: true,
          maxLines: 2,
        )
      ],
    );
  }
}
