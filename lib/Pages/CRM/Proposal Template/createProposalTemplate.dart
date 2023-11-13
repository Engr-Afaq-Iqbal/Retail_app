import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Controllers/CRMControllers/ProposalTemplateController/proposalTemplateController.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../../const/dimensions.dart';
import '../ContactsLogin/ContactsLoginWidgets/contactsDropDown.dart';

class CreateProposalTemplate extends StatefulWidget {
  String? title;
  CreateProposalTemplate({super.key, this.title});

  @override
  State<CreateProposalTemplate> createState() => _CreateProposalTemplateState();
}

class _CreateProposalTemplateState extends State<CreateProposalTemplate> {
  ProposalTemplateController proposalTempCtrl = Get.find<ProposalTemplateController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${widget.title}'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  boxShadow: [BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: kHintColor.withOpacity(0.2)
                  )]
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Sent to:*'),
                    SizedBox(
                      width: width * 0.85,
                      height: height * 0.05,
                      child: ContactsDropDown(),
                    ),
                    SizedBox(height: 15,),
                    title(txt: 'CC:'),
                    SizedBox(
                      width: width * 0.85,
                      height: height * 0.07,
                      child: AppFormField(
                        // isLabel: true,
                        // labelText: 'Campaign Name',
                        isDense: true,
                        controller: proposalTempCtrl.ccCtrl,
                      ),
                    ),

                    title(txt: 'BCC:'),
                    SizedBox(
                      width: width * 0.85,
                      height: height * 0.07,
                      child: AppFormField(
                        // isLabel: true,
                        // labelText: 'Campaign Name',
                        isDense: true,
                        controller: proposalTempCtrl.bccCtrl,
                      ),
                    ),

                    //Subject
                    title(txt: 'Subject:*'),
                    SizedBox(
                      width: width * 0.85,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Subject',
                        isDense: true,
                        controller: proposalTempCtrl.subjectCtrl,
                      ),
                    ),

                    //Email Body
                    title(txt: 'Email Body:*'),
                    SizedBox(
                      width: width * 0.85,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isLabel: true,
                        // labelText: 'Campaign Name',
                        maxLines: 5,
                        // isDense: true,
                        controller: proposalTempCtrl.emailBodyCtrl,
                      ),
                    ),

                    //Attachments
                    title(txt: 'Attachments:'),
                    if(widget.title == 'Proposal Send')
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8),
                      color: kHintColor.withOpacity(0.1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(txt: 'Document'),
                              Image.asset('assets/yt.png',height: 70,width: 60,),
                              Text('YT.png',style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(txt: 'Action:'),
                              Row(
                                children: [
                                  CustomButton(
                                    leading: Icon(Icons.download, color: kWhiteColor,size: 20,),
                                    title: Text(''),
                                    onTap: (){},
                                  ),
                                  SizedBox(width: 5,),
                                  CustomButton(
                                    leading: Icon(Icons.delete,color: kWhiteColor,size: 20,),
                                    title: Text(''),
                                    bgColor: buttonColor,
                                    onTap: (){},
                                  )
                                ],
                              )

                            ],
                          )
                        ],
                      ),
                    ),
                    if(widget.title != 'Proposal Send')
                    GestureDetector(
                      onTap: (){
                        proposalTempCtrl.attachmentImage();
                      },
                      child: SizedBox(
                        width: width * 0.85,
                        // height: height * 0.07,
                        child: AppFormField(
                          // isLabel: true,
                          // labelText: 'Campaign Name',
                          // maxLines: 5,
                          readOnly: true,
                          suffixIcon: Icon(Icons.attach_file_outlined, ),
                          isDense: true,
                          controller: proposalTempCtrl.attachmentCtrl,
                        ),
                      ),
                    ),
                    if(widget.title != 'Proposal Send')
                    Text('Max File size: 5MB',style: TextStyle(fontSize: 11,color: kHintColor),),
                    if(widget.title != 'Proposal Send')
                    Expanded(child: Text('Allowed File: .pdf, .csv, .zip, .doc, .docx, .jpeg, .jpg, .png',softWrap: true,style: TextStyle(fontSize: 11,color: kHintColor),)),
                    SizedBox(height: 25,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: Text('Save',style: TextStyle(color: kWhiteColor),),
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
