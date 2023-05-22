import 'dart:io';
import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Controllers/CustomerVisits/CustomerVisitsController.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Components/textfield.dart';

import '../../../Config/utils.dart';

import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import 'meetDetailsView.dart';

class UpdateStatus extends StatefulWidget {
  CustomerVisitsController customerVisitsCtrl;
  int index;
  UpdateStatus(
      {Key? key, required this.customerVisitsCtrl, required this.index})
      : super(key: key);

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  CustomerVisitsController custVisitsCtrlObj =
      Get.find<CustomerVisitsController>();
  String? statusValue;

  Future pickContactImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemporary = File(image.path);
        custVisitsCtrlObj.frontPath = image.path;
        setState(() {
          custVisitsCtrlObj.image = imageTemporary;
        });
      } else {
        return showToast("No Image picked");
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  void dispose() {
    custVisitsCtrlObj.clearAllStatusUpdateFields();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    custVisitsCtrlObj.visitedOnCtrl.text = widget.customerVisitsCtrl
        .customerVisitsListModel?.data[widget.index].visitedOn;
    custVisitsCtrlObj.idCtrl.text = widget
        .customerVisitsCtrl.customerVisitsListModel!.data[widget.index].id
        .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Update Status (Visti ID: ${widget.customerVisitsCtrl.customerVisitsListModel?.data[widget.index].id})'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headings(txt: 'Did you meet with the contact?'),
              GetBuilder<CustomerVisitsController>(
                  builder: (CustomerVisitsController customerVisitsCtrlObj) {
                return Row(
                  children: [
                    Expanded(
                      // height: 20,
                      // width: M,
                      child: CheckboxListTile(
                          value: customerVisitsCtrlObj.meetYes,
                          onChanged: (bool? value) {
                            setState(() {
                              customerVisitsCtrlObj.meetYes = value!;
                              customerVisitsCtrlObj.meetNo = false;
                              customerVisitsCtrlObj.meetWithStatus = '1';
                              customerVisitsCtrlObj.update();
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'Yes',
                            style: TextStyle(color: blackColor),
                          )),
                    ),
                    Expanded(
                      // height: 20,
                      // width: 20,
                      child: CheckboxListTile(
                          value: customerVisitsCtrlObj.meetNo,
                          onChanged: (bool? value) {
                            setState(() {
                              customerVisitsCtrlObj.meetNo = value!;
                              customerVisitsCtrlObj.meetYes = false;
                              customerVisitsCtrlObj.meetWithStatus = '0';
                              customerVisitsCtrlObj.update();
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'No',
                            style: TextStyle(color: blackColor),
                          )),
                    ),
                  ],
                );
              }),
              if (custVisitsCtrlObj.meetNo == true)
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headings(txt: 'Reason:'),
                        AppFormField(
                          width: width * 0.885,
                          controller: custVisitsCtrlObj.meetNoReason,
                          labelText: 'Please Select',
                        ),
                      ],
                    ),
                  ],
                ),
              //if (custVisitsCtrlObj.valueSecond == true)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(
                          txt: 'Take photo of the contact or visited place:*'),
                      Row(
                        children: [
                          CustomButton(
                            title: Text(
                              'Choose File',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            height: 20,
                            borderRadius: 5,
                            onTap: () {
                              pickContactImage();
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            custVisitsCtrlObj.frontPath,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headings(txt: 'Visited On:'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      '${widget.customerVisitsCtrl.customerVisitsListModel?.data[widget.index].visitedOn ?? ' - -'}')
                ],
              ),
              SizedBox(
                height: 15,
              ),
              MeetDetailsView(),
              SizedBox(
                height: 15,
              ),
              IntrinsicHeight(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          headings(txt: 'Visited address:'),
                          SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            title: Text(
                              'Get current location',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            height: 20,
                            borderRadius: 5,
                            onTap: () {},
                          )
                        ],
                      ),
                      Text('Southwest 17th Way, Christian Gardens'),
                      SizedBox(
                        height: 10,
                      ),
                      headings(txt: 'Discussions with the contact:'),
                      AppFormField(
                        controller: custVisitsCtrlObj.discussionCtrl,
                        labelText: '',
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
                              custVisitsCtrlObj.updateCustomerVisitsStatus();
                            },
                            bgColor: primaryColor,
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
                              Get.back();
                            },
                            bgColor: buttonColor,
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
      ),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
      softWrap: true,
      maxLines: 2,
    );
  }
}
