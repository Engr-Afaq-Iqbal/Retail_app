import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/textfield.dart';
import '../../Controllers/StockTransferController/stockTransferController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({Key? key}) : super(key: key);

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.69,
      child: ListView.builder(
          padding:
              EdgeInsetsDirectional.only(top: 5, bottom: 5, start: 10, end: 10),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: index.isEven ? kWhiteColor : primaryColor.withOpacity(0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AppFormField(
                          controller: stockTranCtrlObj.productNameCtrl,
                          padding: EdgeInsets.only(right: 10),
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                          // labelText: 'Product Name',
                        ),
                      ),
                      Expanded(flex: 1, child: Text('355')
                          // AppFormField(
                          //   controller: stockTranCtrlObj.qtyCtrl,
                          //   padding: EdgeInsets.only(right: 5),
                          //   isOutlineBorder: false,
                          //   isColor:
                          //       index.isEven ? kWhiteColor : Colors.transparent,
                          //   // labelText: 'Qty',
                          // ),
                          ),
                      Expanded(
                        flex: 1,
                        child: AppFormField(
                          controller: stockTranCtrlObj.priceCtrl,
                          padding: EdgeInsets.only(right: 5),
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                          // labelText: 'Price',
                        ),
                      ),
                      Expanded(flex: 1, child: Text('0.00')
                          // AppFormField(
                          //   controller: stockTranCtrlObj.totalCtrl,
                          //   padding: EdgeInsets.only(right: 5),
                          //   isOutlineBorder: false,
                          //   isColor:
                          //       index.isEven ? kWhiteColor : Colors.transparent,
                          //   // labelText: '1',
                          // ),
                          )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('Unit: PCS')
                          // AppFormField(
                          //   controller: stockTranCtrlObj.remarksCtrl,
                          //   padding: EdgeInsets.only(right: 10),
                          //   labelText: 'Remarks',
                          //   isOutlineBorder: false,
                          //   isColor:
                          //       index.isEven ? kWhiteColor : Colors.transparent,
                          // ),
                          ),
                      Icon(
                        Icons.cancel_outlined,
                        color: buttonColor,
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Divider(
                  //
                  // ),
                ],
              ),
            );
          }),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
    );
  }
}
