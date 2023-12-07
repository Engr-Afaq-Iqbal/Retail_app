import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Controllers/AllSalesController/allSalesController.dart';
import '../../Components/textfield.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class SearchSaleProducts extends StatefulWidget {
  const SearchSaleProducts({Key? key}) : super(key: key);

  @override
  State<SearchSaleProducts> createState() => _SearchSaleProductsState();
}

class _SearchSaleProductsState extends State<SearchSaleProducts> {
  AllSalesController allSalesCtrlObj = Get.find<AllSalesController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
          padding:
              EdgeInsetsDirectional.only(top: 5, bottom: 5, start: 10, end: 10),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 2,
          itemBuilder: (context, index) {
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
                        child: AppFormField(
                          controller: allSalesCtrlObj.productNameCtrl,
                          padding: EdgeInsets.only(right: 10),
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                          // labelText: 'Product Name',
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppFormField(
                          controller: allSalesCtrlObj.qtyCtrl,
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
                          controller: allSalesCtrlObj.priceCtrl,
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
                          controller: allSalesCtrlObj.totalCtrl,
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
                        flex: 1,
                        child: AppFormField(
                          controller: allSalesCtrlObj.remarksCtrl,
                          padding: EdgeInsets.only(right: 150),
                          labelText: 'Discount',
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                        ),
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
