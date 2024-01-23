
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/textfield.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Controllers/FundsController/fundsController.dart';
import '../../Services/storage_services.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class FundsTransfer extends StatefulWidget {
  const FundsTransfer({Key? key}) : super(key: key);

  @override
  State<FundsTransfer> createState() => _FundsTransferState();
}

class _FundsTransferState extends State<FundsTransfer> {
  FundsController fundsCtrlObj = Get.find<FundsController>();

  String frontPath = 'no_file_choosen'.tr;
  Future pickContactImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      // int? fileSizeInBytes = await image?.length();
      // double fileSizeInKB = fileSizeInBytes! / 1024;
      // double fileSizeInMB = fileSizeInKB / 1024;
      // print('size ${fileSizeInMB}');
      // print(fileSizeInMB);
      if (image != null) {
        // && fileSizeInMB <= 1
        final imageTemporary = File(image.path);
        frontPath = image.path;
        setState(() {
          fundsCtrlObj.image = imageTemporary;
        });
      }
      // else if (fileSizeInMB > 1) {
      //   return showToast('file_size_isGreater'.tr);
      // }
      else {
        return showToast('no_image_picked'.tr);
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  Future<void> _showDatePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    fundsCtrlObj.dateCtrl.text =
    '${AppFormat.dateYYYYMMDDHHMM24(dateTime ?? DateTime.now())}';
    print(dateTime);
  }

  @override
  void initState() {
    // TODO: implement initState
    fundsCtrlObj.clearAllFields();
    fundsCtrlObj.dateCtrl.text =
    '${AppFormat.dateYYYYMMDDHHMM24(DateTime.now())}';
    // fundsCtrlObj.checkingFundsFromLocation();
    fundsCtrlObj.fromStatusCtrl.text =
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.paymentAccount?.first.account?.name}';
    // print(
    //     'Name : ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.locationId}');
    print(
        'New Name : ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.paymentAccount?.first.account?.name}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('funds_transfer'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headings(txt: 'funds_from'.tr + ':'),
              AppFormField(
                padding: EdgeInsets.only(bottom: 5),
                labelText: 'funds_from'.tr,
                // title: 'amount'.tr + ': *',
                readOnly: true,
                controller: fundsCtrlObj.fromStatusCtrl,
                // keyboardType: TextInputType.number,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.06,
              //   width: MediaQuery.of(context).size.width,
              //   child: GetBuilder<FundsController>(
              //       builder: (FundsController fundsCtrl) {
              //     return DropdownButtonHideUnderline(
              //       child: DropdownButton2(
              //         isExpanded: true,
              //         hint: Align(
              //             alignment: AlignmentDirectional.centerStart,
              //             child: Text(
              //               'please_select'.tr,
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w500),
              //             )),
              //         items: fundsCtrl.paymentAccountList().map((String items) {
              //           return DropdownMenuItem(
              //             value: items,
              //             child: Padding(
              //               padding:
              //                   const EdgeInsets.symmetric(horizontal: 10.0),
              //               child: Text(items),
              //             ),
              //           );
              //         }).toList(),
              //         value: fundsCtrlObj.fromStatus,
              //         dropdownWidth: MediaQuery.of(context).size.width * 0.5,
              //         dropdownDecoration:
              //             BoxDecoration(borderRadius: BorderRadius.circular(5)),
              //         dropdownMaxHeight:
              //             MediaQuery.of(context).size.height * 0.7,
              //         dropdownPadding: EdgeInsets.only(left: 5),
              //         buttonPadding: EdgeInsets.only(left: 10, right: 10),
              //         onChanged: (String? value) {
              //           setState(() {
              //             fundsCtrlObj.fromStatus = value;
              //             fundsCtrl.fromStatusValue = fundsCtrl
              //                 .paymentAccountModel
              //                 ?.data?[fundsCtrl
              //                     .paymentAccountList()
              //                     .indexOf(value!)]
              //                 .id
              //                 .toString();
              //             print(fundsCtrl.fromStatusValue);
              //           });
              //         },
              //         buttonDecoration: BoxDecoration(
              //             color: kWhiteColor,
              //             border: Border.all(
              //                 width: 1,
              //                 color: Theme.of(context).colorScheme.primary),
              //             borderRadius: BorderRadius.circular(15)),
              //         itemHeight: 40,
              //         itemPadding: EdgeInsets.zero,
              //         itemHighlightColor: Theme.of(context).colorScheme.primary,
              //       ),
              //     );
              //   }),
              // ),
              headings(txt: 'funds_to'.tr + ':'),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                child: GetBuilder<FundsController>(
                    builder: (FundsController fundsCtrl) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'please_select'.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )),
                          items: fundsCtrl.paymentAccountList().map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(items),
                              ),
                            );
                          }).toList(),
                          value: fundsCtrlObj.toStatus,
                          dropdownWidth: MediaQuery.of(context).size.width * 0.5,
                          dropdownDecoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                          dropdownMaxHeight:
                          MediaQuery.of(context).size.height * 0.7,
                          dropdownPadding: EdgeInsets.only(left: 5),
                          buttonPadding: EdgeInsets.only(left: 10, right: 10),
                          onChanged: (String? value) {
                            setState(() {
                              fundsCtrl.toStatus = value;
                              fundsCtrl.toStatusValue = fundsCtrl
                                  .paymentAccountModel
                                  ?.data?[fundsCtrl
                                  .paymentAccountList()
                                  .indexOf(value!)]
                                  .id
                                  .toString();
                              print(fundsCtrl.toStatusValue);
                              // productCtrlObj.discountType.text = value!;
                            });
                          },
                          buttonDecoration: BoxDecoration(
                              color: kWhiteColor,
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(15)),
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          itemHighlightColor: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }),
              ),
              headings(txt: 'amount'.tr + ':'),
              SizedBox(
                height: 5,
              ),
              AppFormField(
                padding: EdgeInsets.only(bottom: 5),
                labelText: 'amount'.tr,
                title: 'amount'.tr + ': *',
                controller: fundsCtrlObj.amountCtrl,
                keyboardType: TextInputType.number,
              ),
              headings(txt: 'transaction_date'.tr + ':'),
              SizedBox(
                height: 5,
              ),
              AppFormField(
                // width: MediaQuery.of(context).size.width * 0.43,
                readOnly: true,
                controller: fundsCtrlObj.dateCtrl,
                labelText: 'select_date'.tr,
                prefixIcon: Icon(Icons.calendar_month),
                onTap: () {
                  setState(() {
                    _showDatePicker();

                    //_show(context);
                  });
                },
              ),
              headings(txt: 'document'.tr + ':'),
              GestureDetector(
                onTap: () {
                  pickContactImage();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(20),
                      color: kWhiteColor),
                  child: (fundsCtrlObj.image != null)
                      ? Center(
                    child: Image.file(
                      fundsCtrlObj.image!,
                      fit: BoxFit.contain,
                    ),
                  )
                      : Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              headings(txt: 'note'.tr + ':'),
              SizedBox(
                height: 5,
              ),
              AppFormField(
                // width: MediaQuery.of(context).size.width * 0.43,
                readOnly: false,
                controller: fundsCtrlObj.noteCtrl,
                labelText: 'enter_notes'.tr,
                maxLines: 1,
              ),
              CustomButton(
                title: Text(
                  'submit'.tr,
                  style: TextStyle(color: kWhiteColor),
                ),
                onTap: () {
                  showProgress();
                  fundsCtrlObj.createFundsTransfer();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
    );
  }
}
