import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/textfield.dart';
import '../../Controllers/StockTransferController/stockTransferController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class SearchStockProducts extends StatefulWidget {
  SearchStockProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchStockProducts> createState() => _SearchStockProductsState();
}

class _SearchStockProductsState extends State<SearchStockProducts> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  @override
  void initState() {
    super.initState();
    // Add an initial text field controller
    stockTranCtrlObj.qtyCtrl.add(TextEditingController());
    stockTranCtrlObj.productNameeCtrl.add(TextEditingController());
  }

  @override
  void dispose() {
    // Dispose all text field controllers

    for (var controller in stockTranCtrlObj.productNameeCtrl) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: GetBuilder<StockTransferController>(
          builder: (StockTransferController stockTransferCtrlObj) {
        return ListView.builder(
            padding: EdgeInsetsDirectional.only(
                top: 5, bottom: 5, start: 10, end: 10),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: stockTransferCtrlObj.listForStockAdjustment?.length ?? 0,
            itemBuilder: (context, index) {
              stockTranCtrlObj.qtyCtrl[index].text = '1';
              // stockTranCtrlObj.totalCtrl.text = stockTransferCtrlObj.searchProductModel![index].qtyAvailable!;
              stockTranCtrlObj.priceCtrl.text = stockTransferCtrlObj
                  .listForStockAdjustment![index].sellingPrice!;
              return Container(
                margin: EdgeInsets.only(
                  bottom: 5,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: index.isEven
                    ? kWhiteColor
                    : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                                '${stockTransferCtrlObj.listForStockAdjustment?[index].name ?? ''} ${stockTransferCtrlObj.listForStockAdjustment?[index].subSku ?? ''}')
                            //     AppFormField(
                            //   controller:
                            //       stockTranCtrlObj.productNameCtrl,
                            //   padding: EdgeInsets.only(right: 10),
                            //   isOutlineBorder: false,
                            //   isColor:
                            //       index.isEven ? kWhiteColor : Colors.transparent,
                            //   // labelText: 'Product Name',
                            // ),
                            ),
                        Expanded(
                          flex: 1,
                          child: AppFormField(
                            controller: stockTranCtrlObj.qtyCtrl[index],
                            labelText:
                                '${stockTransferCtrlObj.listForStockAdjustment?[index].name ?? ''}',
                            padding: EdgeInsets.only(right: 5),
                            isOutlineBorder: false,
                            isColor:
                                index.isEven ? kWhiteColor : Colors.transparent,
                            // labelText: 'Qty',
                          ),
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
                        Expanded(
                          flex: 1,
                          child: AppFormField(
                            controller: stockTranCtrlObj.totalCtrl,
                            padding: EdgeInsets.only(right: 5),
                            isOutlineBorder: false,
                            isColor:
                                index.isEven ? kWhiteColor : Colors.transparent,
                            // labelText: '1',
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: AppFormField(
                            controller: stockTranCtrlObj.remarksCtrl,
                            padding: EdgeInsets.only(right: 10),
                            labelText: 'Remarks',
                            isOutlineBorder: false,
                            isColor:
                                index.isEven ? kWhiteColor : Colors.transparent,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.cancel_outlined,
                            color: buttonColor,
                          ),
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
            });
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
