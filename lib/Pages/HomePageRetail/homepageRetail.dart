import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const/CurvedContainer.dart';
import '../AddItem/additem.dart';
import '../CustomesVisit/customersVisit.dart';
import '../Orders/View/OrdersTabPage.dart';

import '../Receipts/receipts.dart';
import '../Return/return.dart';
import '../SalesView/SalesTabPage.dart';
import '../SalesView/SalesViewDetails/SalesView.dart';
import '../Upload/upload.dart';
import '../home_page.dart';
import '../order_type/search_customer_page.dart';

class HomePageRetail extends StatefulWidget {
  const HomePageRetail({Key? key}) : super(key: key);

  @override
  State<HomePageRetail> createState() => _HomePageRetailState();
}

class _HomePageRetailState extends State<HomePageRetail> {
  List<IconData> iconList = [
    FontAwesomeIcons.store,
    FontAwesomeIcons.user,
    FontAwesomeIcons.database,
    FontAwesomeIcons.divide,
    FontAwesomeIcons.print,
    FontAwesomeIcons.arrowUpRightDots,
    FontAwesomeIcons.boxesStacked,
    FontAwesomeIcons.personWalking,
    FontAwesomeIcons.upload
  ];

  List<String> names = [
    'Total Customer Visited',
    'Unsuccessful Visits',
    'Customer Invoiced Today',
    'Sales Amount Today',
    'Total Cash Collected',
    'Cheque Collected Today',
    'MTD Actual',
    'My Target',
    'Target-Slab',
  ];

  List<String> iconsNames = [
    'Items',
    'Customer',
    'Create Order',
    'Return',
    'Receipt',
    'Sales',
    'Stock',
    'Customer Visits',
    'Upload'
  ];

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedContainer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.29,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kWhiteColor,
              ),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // number of columns
                  mainAxisSpacing: 5.0, // space between rows
                  crossAxisSpacing: 5.0, // space between columns
                  childAspectRatio: 1.0, // width/height ratio of items
                ),
                itemCount: iconList.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            iconList[index],
                            color: primaryColor,
                            size: 20,
                          ),
                          onPressed: () {
                            // handle icon tap
                            if (index == 0) {
                              //Get.to(AddItem());
                              Get.to(HomePage());
                            }
                            if (index == 2) {
                              Get.to(CustomerSearch());
                            }
                            if (index == 3) {
                              Get.to(Return());
                            }
                            if (index == 4) {
                              Get.to(Receipts());
                            }
                            if (index == 5) {
                              Get.to(SalesTabPage());
                            }
                            if (index == 6) {
                              Get.to(OrdersTabPage());
                            }
                            if (index == 7) {
                              Get.to(CustomerVisits());
                            }
                            if (index == 8) {
                              Get.to(Upload());
                            }
                          },
                        ),
                        Text(
                          iconsNames[index],
                          style: TextStyle(color: blackColor, fontSize: 9),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of columns
                  mainAxisSpacing: 10.0, // space between rows
                  crossAxisSpacing: 10.0, // space between columns
                  childAspectRatio: 1.0, // width/height ratio of items
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(names[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: kWhiteColor, fontSize: 12),
                              textAlign: TextAlign.center),
                        ),
                        Text(
                          '0.0',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: kHintColor),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
