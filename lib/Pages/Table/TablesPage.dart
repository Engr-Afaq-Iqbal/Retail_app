import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Controllers/TableSelectionController/table_management_controller.dart';
import '/Models/TableManagementModel/table_management_model.dart';
import '/Pages/Table/TableTile.dart';

class TablesPage extends StatelessWidget {
  final bool isForBookedTables;
  final Function()? tableCartSelectionCallBack;
  final bool isAllowMultiSelection;
  const TablesPage(
      {this.isForBookedTables = false,
      this.isAllowMultiSelection = false,
      this.tableCartSelectionCallBack,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: (!isForBookedTables)
          ? AppBar(
              centerTitle: true,
              //  title:
              // title: FadedScaleAnimation(
              //   SizedBox(
              //       height: 50,
              //       child: Image(image: AssetImage(AppImages.eMenuLogo))),
              //   durationInMilliseconds: 400,
              // ),

              // actions: [
              //   IconButton(
              //     onPressed: () => Get.to(() => AppMenuPage()),
              //     icon: Icon(Icons.menu, color: Colors.black),
              //   )
              // ],
            )
          : null,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              (isForBookedTables)
                  ? Text(
                      'active_tables'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  : SizedBox(),
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: GetBuilder(
                  initState: (_) {
                    Get.find<TableSelectionController>().fetchTables();
                  },
                  builder: (TableSelectionController tableCtrlObj) {
                    if (tableCtrlObj.tableRecord() != null) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await tableCtrlObj.fetchTables();
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.all(15),
                          itemCount: tableCtrlObj
                              .tableRecord(isForBookedTables: isForBookedTables)
                              ?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isPortrait ? 2 : 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            TableDataModel _tableData =
                                tableCtrlObj.tableRecord(
                                    isForBookedTables:
                                        isForBookedTables)![index];
                            return GestureDetector(
                              onTap: () {
                                //if (isForBookedTables)
                                tableCtrlObj.tableTapAction(
                                  _tableData,
                                  tableCartSelectionCallBack:
                                      tableCartSelectionCallBack,
                                );
                              },
                              child: TableTile(_tableData),
                            );
                            // return GestureDetector(
                            //   child: FadedScaleAnimation(
                            //     TableTile(_tableData),
                            //     durationInMilliseconds: 200,
                            //   ),
                            // );
                          },
                        ),
                      );
                    } else if (!tableCtrlObj.isTablesLoaded) {
                      return progressIndicator();
                    } else {
                      /// refresh button with some information.
                      return Center(
                        child: IconButton(
                          onPressed: () {
                            tableCtrlObj.fetchTables();
                          },
                          icon: Icon(Icons.refresh_rounded),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
