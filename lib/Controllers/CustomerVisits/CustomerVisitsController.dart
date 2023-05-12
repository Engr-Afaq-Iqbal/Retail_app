import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerVisitsController extends GetxController {
  bool valuefirst = false;
  bool valueSecond = false;
  bool meetYes = true;
  bool meetNo = false;
  TextEditingController meetNoReason = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController additionalNotes = TextEditingController();
  String? statusValue;
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController visitAddressCtrl = TextEditingController();
  TextEditingController companyCtrl = TextEditingController();
  TextEditingController discussionCtrl = TextEditingController();
  TextEditingController meetWithCtrl = TextEditingController();
  TextEditingController mobileNbrCtrl = TextEditingController();
  TextEditingController designationCtrl = TextEditingController();
  List<String> assignedToList() {
    List<String> options = ['Mr Super Admin', 'Mr Cashier Cashier', 'Koi Pran'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> customersMeeteaders = [
    '#',
    'Meet with',
    'Mobile No.',
    'Designation',
  ];
}
