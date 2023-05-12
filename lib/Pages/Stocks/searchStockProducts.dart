import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/textfield.dart';
import '../../Controllers/StockTransferController/stockTransferController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

class SearchStockProducts extends StatefulWidget {
  const SearchStockProducts({Key? key}) : super(key: key);

  @override
  State<SearchStockProducts> createState() => _SearchStockProductsState();
}

class _SearchStockProductsState extends State<SearchStockProducts> {
  StockTransferController stockTranCtrlObj = Get.find<StockTransferController>();
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
            headings(txt: 'Search Products'),
            AppFormField(
              width: width,
              controller: stockTranCtrlObj.searchCtrl,
              labelText: 'Search Product for Stock Adjustment',
              prefixIcon: Icon(Icons.search),
            ),
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

                    headingRowColor:
                    MaterialStateProperty.all(
                        primaryColor),

                    //border: TableBorder.symmetric(inside: BorderSide(color: Colors.white),outside: BorderSide(color: Colors.black)),
                    columns: stockTranCtrlObj.stockSearchHeader
                        .map(
                          (e) => DataColumn2(
                        label: Text('${e}'.tr,
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                color: Colors.white)),
                        size: ColumnSize.L,
                        //onSort: (int i, bool asc) {},
                      ),
                    )
                        .toList(),
                    rows: List<DataRow>.generate(
                      1,
                          (index) {
                        return DataRow2(
                          color: index.isEven
                              ? MaterialStateProperty.all(
                              Colors.white)
                              : MaterialStateProperty.all(
                              Colors.grey
                                  .withOpacity(0.05)),
                          cells: [
                            ///Products
                            DataCell(
                              Text(''),
                            ),

                            ///Sub Location
                            DataCell(
                              Text(
                                '',
                              ),
                            ),

                            ///Quantity
                            DataCell(
                              Text(
                                  ''),
                            ),

                            ///Unit Price
                            DataCell(
                              Text(
                                  ''),
                            ),

                            ///Subtotal
                            DataCell(
                              Text(
                                  ''),
                            ),


                            ///Remarks
                            DataCell(
                              Text(
                                  ''),
                            ),

                            ///Delete button
                            DataCell(
                                Icon(Icons.delete_outlined)
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                headings(txt: 'Total: 0.00')
              ],
            )

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
