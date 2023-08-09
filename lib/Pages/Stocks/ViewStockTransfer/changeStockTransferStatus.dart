import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';

class ChangeStockTransferStatus extends StatefulWidget {
  int? id;
  ChangeStockTransferStatus({Key? key, this.id}) : super(key: key);

  @override
  State<ChangeStockTransferStatus> createState() =>
      _ChangeStockTransferStatusState();
}

class _ChangeStockTransferStatusState extends State<ChangeStockTransferStatus> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();
  List<String> getStatusList() {
    // List<String> options = ['Pending', 'In Transit', 'Completed'];
    List<String> optionsStatus = [];
    if (stockTranCtrlObj.statusListModel != null) {
      for (int i = 0; i < stockTranCtrlObj.statusListModel!.length; i++) {
        optionsStatus.add('${stockTranCtrlObj.statusListModel?[i].value}');
      }
    }

    return optionsStatus;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Status',
              style: appBarHeaderStyle,
            ),
            Divider(),
            Text(
              'status'.tr + ':*',
              style: appBarHeaderStyle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<StockTransferController>(
                    builder: (StockTransferController stockCtrl) {
                  if (stockCtrl.statusListModel == null) {
                    return progressIndicator();
                  }
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'please_select'.tr,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: txtFieldHintColor,
                            ),
                          )),
                      items: getStatusList().map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      value: stockCtrl.updateStatusValue,
                      dropdownDirection: DropdownDirection.textDirection,
                      dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                      buttonPadding: EdgeInsets.only(left: 15, right: 15),
                      onChanged: (String? value) {
                        setState(() {
                          stockCtrl.updateStatusValue = value;
                        });
                      },
                      buttonHeight: MediaQuery.of(context).size.height * 0.06,
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonDecoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(15),
                          color: kWhiteColor),
                      itemHeight: 40,
                      itemPadding: EdgeInsets.zero,
                      itemHighlightColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  title: Text(
                    'Update',
                    style: TextStyle(color: kWhiteColor),
                  ),
                  onTap: () {
                    showProgress();
                    stockTranCtrlObj.updateStockStatus(id: '${widget.id}');
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                CustomButton(
                  title: Text(
                    'Close',
                    style: TextStyle(color: kWhiteColor),
                  ),
                  onTap: () {
                    Get.close(1);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
