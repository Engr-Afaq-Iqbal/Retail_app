import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/textfield.dart';
import '../../Controllers/SalesReturnController/saleReturnController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class SaleReturnProductList extends StatefulWidget {
  const SaleReturnProductList({Key? key}) : super(key: key);

  @override
  State<SaleReturnProductList> createState() => _SaleReturnProductListState();
}

class _SaleReturnProductListState extends State<SaleReturnProductList> {
  final SaleReturnController saleReturnCtrlObj =
      Get.find<SaleReturnController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
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
              color: index.isEven ? kWhiteColor : primaryColor.withOpacity(0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AppFormField(
                          controller: saleReturnCtrlObj.productNameCtrl,
                          padding: EdgeInsets.only(right: 5),
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                          // labelText: '1',
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '10',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '10',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppFormField(
                          controller: saleReturnCtrlObj.returnQtyCtrl,
                          padding: EdgeInsets.only(right: 5),
                          isOutlineBorder: false,
                          isColor:
                              index.isEven ? kWhiteColor : Colors.transparent,
                          // labelText: '1',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Subtotal:- 100',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.cancel_outlined,
                        color: buttonColor,
                      )
                    ],
                  ),
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
