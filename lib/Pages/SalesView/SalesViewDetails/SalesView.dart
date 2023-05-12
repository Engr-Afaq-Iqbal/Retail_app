import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/colors.dart';
import 'AddSalesAndQuotation.dart';
import 'SalesViewTile.dart';
import 'ViewSalesPage.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    child: AddSalesAndQuotation(
                      isSale: true,
                    ),
                  );
                },
              );
            }),
        // appBar: AppBar(
        //   title: Text('Sales'),
        // ),
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
                    child: SalesViewTile()),
              );
            }));
  }
}
