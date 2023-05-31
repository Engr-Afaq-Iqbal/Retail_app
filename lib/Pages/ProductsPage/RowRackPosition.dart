import 'package:bizmodo_emenu/Controllers/CustomerVisits/CustomerVisitsController.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../Controllers/ProductsRetailController/productsRetailsController.dart';

class RowRackPosition extends StatefulWidget {
  RowRackPosition({
    Key? key,
  }) : super(key: key);

  @override
  State<RowRackPosition> createState() => _RowRackPositionState();
}

class _RowRackPositionState extends State<RowRackPosition> {
  ProductsRetailController prodRetailCtrlObj =
      Get.find<ProductsRetailController>();
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
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    columns: prodRetailCtrlObj.rowRackList
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
                            ///Meet with
                            DataCell(
                              AppFormField(
                                controller: prodRetailCtrlObj.rackCtrl,
                                isOutlineBorder: false,
                              ),
                            ),

                            ///Mobile No.
                            DataCell(
                              AppFormField(
                                controller: prodRetailCtrlObj.rowCtrl,
                                isOutlineBorder: false,
                              ),
                            ),

                            ///Designation
                            DataCell(
                              AppFormField(
                                controller: prodRetailCtrlObj.positionCtrl,
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
