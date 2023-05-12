import 'package:bizmodo_emenu/Controllers/CustomerVisits/CustomerVisitsController.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

class MeetDetailsView extends StatefulWidget {
  bool? isView;
  MeetDetailsView({Key? key, this.isView = false}) : super(key: key);

  @override
  State<MeetDetailsView> createState() => _MeetDetailsViewState();
}

class _MeetDetailsViewState extends State<MeetDetailsView> {
  CustomerVisitsController custVisitsCtrlObj =
      Get.find<CustomerVisitsController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return IntrinsicHeight(
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
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: DataTable(
                    //sortAscending: ascending,
                    sortColumnIndex: 1,
                    columnSpacing: 10,
                    showBottomBorder: false,
                    dividerThickness: 0,
                    headingRowColor: MaterialStateProperty.all(primaryColor),
                    columns: custVisitsCtrlObj.customersMeeteaders
                        .map(
                          (e) => DataColumn2(
                            label: Text('${e}'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            size: ColumnSize.L,
                            //onSort: (int i, bool asc) {},
                          ),
                        )
                        .toList(),
                    rows: List<DataRow>.generate(
                      3,
                      (index) {
                        return DataRow2(
                          color: index.isEven
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.05)),
                          cells: [
                            ///index
                            DataCell(
                              Text('${index + 1}'),
                            ),

                            ///Meet with
                            DataCell(
                              (widget.isView == true)
                                  ? Text('Ewew')
                                  : AppFormField(
                                      controller:
                                          custVisitsCtrlObj.meetWithCtrl,
                                      isOutlineBorder: false,
                                    ),
                            ),

                            ///Mobile No.
                            DataCell(
                              (widget.isView == true)
                                  ? Text('78902')
                                  : AppFormField(
                                      controller:
                                          custVisitsCtrlObj.mobileNbrCtrl,
                                      isOutlineBorder: false,
                                    ),
                            ),

                            ///Designation
                            DataCell(
                              (widget.isView == true)
                                  ? Text('klkl')
                                  : AppFormField(
                                      controller:
                                          custVisitsCtrlObj.designationCtrl,
                                      isOutlineBorder: false,
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
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
