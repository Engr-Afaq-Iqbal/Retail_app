import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const/CurvedContainer.dart';
import '../AddItem/additem.dart';
import '../Stock Transfer/stock_transfer.dart';

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
    'Store',
    'Customer',
    'Supply',
    'Return',
    'Receipt',
    'Sales',
    'Stock',
    'Upload',
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
              height: MediaQuery.of(context).size.height * 0.19,
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
                              Get.to(AddItem());
                            }
                            if (index == 6) {
                              Get.to(StockTransfer());
                            }
                          },
                        ),
                        Text(
                          iconsNames[index],
                          style: TextStyle(color: blackColor),
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
