import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/RepairController/RepairSettingsController/repairSettingsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Components/textfield.dart';
import '../../../../../Theme/colors.dart';
import '../../../../../Theme/style.dart';
import '../../../../../const/dimensions.dart';

class SettingsJobSheetPdfLabel extends StatefulWidget {
  const SettingsJobSheetPdfLabel({super.key});

  @override
  State<SettingsJobSheetPdfLabel> createState() => _SettingsJobSheetPdfLabelState();
}

class _SettingsJobSheetPdfLabelState extends State<SettingsJobSheetPdfLabel> {
  RepairSettingsController repairSetCtrl = Get.find<RepairSettingsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 3,
                        color: kHintColor.withOpacity(0.2)
                    ),
                  ]
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Job Sheet PDF:',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    Text('Fields for customer details::',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isShowCustomer,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isShowCustomer = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Show Customer Information'),
                      ],
                    ),

                    title(txt: 'Customer Label:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Customer Label',
                        isDense: true,
                        controller: repairSetCtrl.customerLabelCtrl,
                      ),
                    ),

                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isShowClientId,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isShowClientId = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Show client ID'),
                      ],
                    ),
                    title(txt: 'Client ID Label:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Client ID Label',
                        isDense: true,
                        controller: repairSetCtrl.clientIdLabelCtrl,
                      ),
                    ),
                    title(txt: 'Client tax number label:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Client tax number label',
                        isDense: true,
                        controller: repairSetCtrl.clientTaxNumberLabelCtrl,
                      ),
                    ),

                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: repairSetCtrl.isEmiratesId,
                              onChanged: (bool? value) {
                                setState(() {
                                  repairSetCtrl.isEmiratesId = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 5,),
                            Text('Emirate ID'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: repairSetCtrl.isPassportNo,
                              onChanged: (bool? value) {
                                setState(() {
                                  repairSetCtrl.isPassportNo = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 5,),
                            Text('Passport No'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: repairSetCtrl.isTradeLicense,
                              onChanged: (bool? value) {
                                setState(() {
                                  repairSetCtrl.isTradeLicense = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 5,),
                            Text('Trade License'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: repairSetCtrl.isCustomField4,
                              onChanged: (bool? value) {
                                setState(() {
                                  repairSetCtrl.isCustomField4 = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 5,),
                            Text('Custom Field 4'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 3,
                        color: kHintColor.withOpacity(0.2)
                    ),
                  ]
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Job Sheet Label:',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    title(txt: 'Label width(MM):'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelWidthCtrl,
                      ),
                    ),

                    title(txt: 'Label Height(MM):'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelHeightCtrl,
                      ),
                    ),

                    Text('Customer Information:',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isCustomerName,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isCustomerName = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Customer name'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isCustomerAddress,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isCustomerAddress = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Customer Address'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isCustomerPhone,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isCustomerPhone = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Customer Phone'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isAlternatePhone,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isAlternatePhone = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Alternate Phone'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isCustomerEmail,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isCustomerEmail = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Customer Email'),
                      ],
                    ),
                    ///Label Details
                    Text('Label Details:',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isSalesPerson,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isSalesPerson = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Sales Person'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isBarcode,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isBarcode = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Barcode (Job Sheet Number)'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isStatus,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isStatus = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Status'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isDueDate,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isDueDate = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Due Date'),
                      ],
                    ),


                    ///Label Information
                    Text('Label Details:',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isTechnician,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isTechnician = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text( 'Technicion'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isProblem,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isProblem = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('Problem'),
                      ],
                    ),


                    ///DeviceInfo
                    Text('Device Info:',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isImei,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isImei = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text('IMEI/Serial No.'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isBrand,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isBrand = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text( 'Brand/Model'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isLocation,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isLocation = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text( 'Location'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: repairSetCtrl.isPassword,
                          onChanged: (bool? value) {
                            setState(() {
                              repairSetCtrl.isPassword = value!;
                            });
                          },
                        ),
                        // SizedBox(width: 5,),
                        Text( 'Password'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: Text('Update',style: TextStyle(color: kWhiteColor),),
                          bgColor: buttonColor,
                          onTap: (){},
                        )
                      ],
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
