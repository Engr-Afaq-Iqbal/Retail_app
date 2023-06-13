import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../Config/utils.dart';
import '../../Controllers/AllSalesController/allSalesController.dart';

class SearchInReceipts extends StatefulWidget {
  SearchInReceipts({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchInReceipts> createState() => _SearchInReceiptsState();
}

class _SearchInReceiptsState extends State<SearchInReceipts> {
  AllSalesController allSalesCtrl = Get.find<AllSalesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.32,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Receipts',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Text(
            'Receipts',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          AppFormField(
            isLabel: false,
            //isDense: false,
            labelText: 'Search Receipts',
            controller: allSalesCtrl.searchReceiptCtrl,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomButton(
                    onTap: () {
                      showProgress();
                      allSalesCtrl.fetchAllSalesList(1,
                          global_search: allSalesCtrl.searchReceiptCtrl.text
                          //  global_search: allSalesCtrl.searchReceiptCtrl.text
                          );
                      // if (saleReturnCtrlObj.isTrue == true) {
                      //
                      // }
                    },
                    btnTxt: 'Search',
                    bgColor: Theme.of(context).colorScheme.primary,
                    borderRadius: 10),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    btnTxt: 'close'.tr,
                    bgColor: Theme.of(context).colorScheme.primary,
                    borderRadius: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
