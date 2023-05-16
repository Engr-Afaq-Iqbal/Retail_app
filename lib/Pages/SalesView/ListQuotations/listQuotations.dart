import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/colors.dart';
import '../SalesViewDetails/AddSalesAndQuotation.dart';
import '../SalesViewDetails/ViewSalesPage.dart';
import 'listQuotationsTile.dart';

class ListQuotations extends StatefulWidget {
  const ListQuotations({Key? key}) : super(key: key);

  @override
  State<ListQuotations> createState() => _ListQuotationsState();
}

class _ListQuotationsState extends State<ListQuotations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              Get.to(
                AddSalesAndQuotation(
                  isSale: false,
                ),
              );
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   context: context,
              //   builder: (context) {
              //     return Container(
              //       child: AddSalesAndQuotation(
              //         isSale: false,
              //       ),
              //     );
              //   },
              // );
            }),
        body: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: 3,
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: GestureDetector(
                    onTap: () {
                      Get.to(SalesViewDetailsPage());
                    },
                    child: ListQuotationTile()),
              );
            }));
  }
}
