import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/enums.dart';
import '/Config/utils.dart';
import '/Models/TableManagementModel/table_management_model.dart';
import '../../Pages/ProductsPage/home_page.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '/Services/storage_services.dart';
import '../../Pages/Orders/View/OrderDetails/OrderDetailsPage.dart';

class TableSelectionController extends GetxController {
  bool isTablesLoaded = true, isTableSelectionValueUpdated = false;

  TableModel? _tableRecord;
  List<TableDataModel>? tableRecord({bool isForBookedTables = false}) {
    try {
      if (_tableRecord == null) return null;
      List<TableDataModel> _temp;
      if (isForBookedTables) {
        _temp = _tableRecord!.tableData
            .where((element) => element.status != TableStatus.FREE)
            .toList();
      } else {
        _temp = _tableRecord!.tableData;
      }
      return _temp;
    } catch (_e) {
      return null;
    }
  }

  RxList<TableDataModel> selectedTables = <TableDataModel>[].obs;
  tableTapAction(TableDataModel _tableData,
      {Function()? tableCartSelectionCallBack}) {
    // set table data in selectedTables variable which also able to carry multiple tables data
    selectedTables.value = [_tableData];

    // override default callback functions check and calling
    if (tableCartSelectionCallBack != null) {
      // if (_tableData.status == TableStatus.FREE)
      tableCartSelectionCallBack();
      return;
    }

    if (_tableData.status == TableStatus.BUSY) {
      Get.to(() => OrderDetailsPage(_tableData.order!));
    }

    if (_tableData.status != TableStatus.FREE
        // _tableData.status == TableStatus.BUSY ||
        //     _tableData.status == TableStatus.RESERVED
        ) {
      showToast('please_choose_free_table'.tr);
      // if (isForBookedTables) {}
      ///commenting the path of Cart page as the table will be busy
      //Get.to(() => CartPage());
      return;
    }
    Get.to(() => HomePage());
  }

  Future<void> fetchTables() async {
    if (AppStorage.isStorageHasTablesData()) {
      isTablesLoaded = true;
      getTableDetail();
    } else {
      isTablesLoaded = false;
      update();
    }
    await ApiServices.getMethod(feedUrl: ApiUrls.getTables).then((_res) async {
      isTablesLoaded = true;
      update();
      if (_res == null) return;
      await AppStorage.setTablesData(_res);
      getTableDetail();
      // update();
    }).onError((error, stackTrace) {
      isTablesLoaded = true;
      update();
      print('Error => $error');
      logger.e('StackTrace => $stackTrace');
    });
  }

  void changeTableStatus(int _tableId, TableStatus status) async {
    if (_tableRecord == null) getTableDetail();

    final tableStatusField = {
      "contact_id": "1",
      "table_id": "$_tableId",
      "status": "${tableStatusValues.reverse?[status]}",
      "persons": "5",
    };
    debugPrint('$tableStatusField');
    await ApiServices.postMethod(
            feedUrl: ApiUrls.updateTableStatus, fields: tableStatusField)
        .then((_res) async {
      isTablesLoaded = true;
      update();
      if (_res == null) return;

      await updateTableInfo(
        // tableId: _tableId,
        // status: status,
        tableData: json.decode(_res)['data'],
      );
      update();
    }).onError((error, stackTrace) {
      isTablesLoaded = true;
      update();
      print('Error => $error');
      logger.e('StackTrace => $stackTrace');
    });
  }

  void getTableDetail() {
    _tableRecord = AppStorage.getTablesData();
    update();
  }

  updateTableInfo(
      {int? tableId,
      TableStatus? status,
      Map<String, dynamic>? tableData}) async {
    if (tableId == null && status == null && tableData == null) {
      /// TODO: Show message in popup related to table update
      fetchTables();
      return;
    }

    if (tableId != null && status != null) {
      int tableIndex =
          _tableRecord!.tableData.indexWhere((_table) => _table.id == tableId);
      if (tableIndex > -1 &&
          _tableRecord!.tableData[tableIndex].status !=
              tableStatusValues.reverse?[status]) {
        TableDataModel _table = _tableRecord!.tableData[tableIndex];
        _tableRecord!.tableData.removeAt(tableIndex);
        _tableRecord!.tableData.insert(tableIndex,
            _table.copyWith(cStatus: tableStatusValues.reverse?[status]));
      }
    } else if (tableData != null) {
      int tableIndex = _tableRecord!.tableData.indexWhere(
          (_table) => _table.id == tableDataModelFromJson(tableData).id);
      if (tableIndex > -1 &&
          _tableRecord!.tableData[tableIndex].status !=
              tableStatusValues.reverse?[status]) {
        _tableRecord!.tableData.removeAt(tableIndex);
        _tableRecord!.tableData
            .insert(tableIndex, tableDataModelFromJson(tableData));
      }
    }

    await AppStorage.setTablesData(jsonEncode(_tableRecord?.toJson()));
    getTableDetail();
  }

  /// TODO: remove its usage
  // TableDataModel? findTableFromRecord(int? tableId) {
  //   if (tableRecord == null) getTableDetail();
  //   return tableRecord?.tableData.firstWhereOrNull((element) {
  //     return element.id == tableId;
  //   });
  // }
}
