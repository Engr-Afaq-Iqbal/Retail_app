import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/OptionSelectionView.dart';
import '../../../Config/utils.dart';
import '../../../Controllers/Booking Controller/BookingController.dart';
import '../../../Controllers/ContactController/ContactController.dart';

class CustomerListView extends StatefulWidget {
  ContactController contactCtrlObj;
  CustomerListView({Key? key, required this.contactCtrlObj}) : super(key: key);

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  final BookingController bookingCtrl = Get.find<BookingController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
        builder: (ContactController customerNameCtrlObj) {
      if (customerNameCtrlObj.customerContacts == null)
        return progressIndicator();

      return RefreshIndicator(
        onRefresh: () async {
          await Get.find<ContactController>().fetchCustomerInfo('');
        },
        child: OptionSelectionView(
          itemCount:
              widget.contactCtrlObj.customerContacts?.contactDataList.length,
          itemBuilder: (context, index) {
            // ExpenseCategoriesListModel? _data1 =
            //     expCtrlObj.expenseCategoriesListModel.expenseCategories[index];
            // ExpenseCategoryDataModel? _data =
            //     expCtrlObj.expenseCategoryInfo?.expenseCategoriesData[index];
            // print(_data1);
            return OptionSelectionTile(
              onTap: () {
                customerNameCtrlObj.customerNameCtrl.text =
                    '${widget.contactCtrlObj.customerContacts?.contactDataList[index].name ?? ''} ${widget.contactCtrlObj.customerContacts?.contactDataList[index].contactId ?? ''}';
                print(
                    '${widget.contactCtrlObj.customerContacts?.contactDataList[index].name}');
                customerNameCtrlObj.contactId = widget.contactCtrlObj
                        .customerContacts?.contactDataList[index].contactId ??
                    '';
                customerNameCtrlObj.searchCustomerCtrl.text =
                    '${widget.contactCtrlObj.customerContacts?.contactDataList[index].name} ${widget.contactCtrlObj.customerContacts?.contactDataList[index].contactId}';
                customerNameCtrlObj.nameCtrl.text = widget.contactCtrlObj
                        .customerContacts?.contactDataList[index].name ??
                    '';
                customerNameCtrlObj.mobileNumberCtrl.text = widget
                        .contactCtrlObj
                        .customerContacts
                        ?.contactDataList[index]
                        .mobile ??
                    '';
                bookingCtrl.contactIdCtrl.text =
                    '${widget.contactCtrlObj.customerContacts?.contactDataList[index].id}';
                print(
                    '${widget.contactCtrlObj.customerContacts?.contactDataList[index].id}');
              }, //=> expCtrlObj.selectedExpenseCategoryCtrl.text = '',
              tileTitle:
                  '${widget.contactCtrlObj.customerContacts?.contactDataList[index].name ?? ''} ${widget.contactCtrlObj.customerContacts?.contactDataList[index].contactId ?? ''} ' ??
                      '',
              itemCount: widget
                  .contactCtrlObj.customerContacts!.contactDataList.length,
            );
          },
        ),
      );
    });
  }
}
