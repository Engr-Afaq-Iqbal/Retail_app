import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/textfield.dart';
import '../../Controllers/ContactController/ContactController.dart';
import 'CustomerListView/CustomerListView.dart';

class SearchCustomerBooking extends StatefulWidget {
  const SearchCustomerBooking({Key? key}) : super(key: key);

  @override
  State<SearchCustomerBooking> createState() => _SearchCustomerBookingState();
}

class _SearchCustomerBookingState extends State<SearchCustomerBooking> {
  final ContactController contactCtrlObj = Get.find<ContactController>();
  @override
  void initState() {
    // TODO: implement initState
    contactCtrlObj.fetchCustomerInfo('');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contactCtrlObj.nameCtrl.clear();
    contactCtrlObj.mobileNumberCtrl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      child: Column(
        children: [
          //  Divider(),
          AppFormField(
            // prefixIcon: Icon(Icons.person),
            // isDense: false,
            readOnly: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('search_customer'.tr),
                  content: CustomerListView(contactCtrlObj: contactCtrlObj),
                ),
              );
            },
            padding: EdgeInsets.only(bottom: 5),
            labelText: 'search_customer'.tr,
            title: 'search_customer'.tr,
            maxLines: 1,
            controller: contactCtrlObj.customerNameCtrl,
            //width: MediaQuery.of(context).size.width * 0.27,
          ),

          AppFormField(
            // isDense: false,
            validator: (String? v) {
              if (v!.isEmpty) return 'field_required'.tr;
              return null;
            },
            labelText: 'customer_name'.tr,
            title: 'customer_name'.tr,
            controller: contactCtrlObj.nameCtrl,
          ),

          AppFormField(
            // isDense: false,
            validator: (String? v) {
              if (v!.isEmpty) return 'field_required'.tr;
              return null;
            },
            labelText: 'mobile_number'.tr,
            title: 'mobile_number'.tr,
            controller: contactCtrlObj.mobileNumberCtrl,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
