import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/DateTimeFormat.dart';
import '/Config/const.dart';
import '/Config/enums.dart';
import '/Controllers/TableSelectionController/table_management_controller.dart';
import '/Models/TableManagementModel/table_management_model.dart';

class TableTile extends StatelessWidget {
  final TableDataModel _tableData;
  TableTile(this._tableData, {Key? key}) : super(key: key);

  final TableSelectionController tableCtrlObj =
      Get.find<TableSelectionController>();

  @override
  Widget build(BuildContext context) {
    bool _isOrderPatched = _tableData.order != null;
    TextStyle textStyle = TextStyle(
      color:
          _tableData.status == TableStatus.FREE ? Colors.black : Colors.white,
      fontWeight: FontWeight.w500,
    );
    return Stack(
      clipBehavior: Clip.hardEdge,
      fit: StackFit.passthrough,
      children: [
        Card(
          color: _tableData.bgColor != null ? Color(_tableData.bgColor!) : null,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Order No. & Status Information
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _tableData.order?.invoiceNo ?? '',
                      style: textStyle.copyWith(fontSize: 10),
                    ),
                    Text(
                      _tableData.status?.name.toLowerCase().tr ??
                          'status_not_available'.tr,
                      style: textStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),

              // Table & Order Information
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('table_drop'.tr, style: textStyle),
                    Text(
                      _tableData.name,
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    ),

                    if (_isOrderPatched)
                      Text(
                        '${_tableData.order?.sellLines.length ?? 0} ' +
                            'orders'.tr,
                        style: textStyle,
                      ),
                    // Divider(),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    if (_isOrderPatched) AppConst.dividerLineLight(height: 0.5),
                    Row(
                      children: [
                        Expanded(
                          child: tableRichText(
                            icon: Icons.person_outline,
                            text: (_tableData.sittingPerson ?? '-') +
                                ' / ' +
                                (_tableData.numOfPerson ?? '-'),
                            defaultTextStyle: textStyle,
                          ),
                        ),
                        if (_isOrderPatched)
                          AppConst.dividerLineLight(height: 25, width: 0.5),
                        if (_isOrderPatched)
                          Expanded(
                            child: (_tableData.updatedAt != null &&
                                    _tableData.status != null &&
                                    _tableData.status != TableStatus.FREE)
                                ? tableRichText(
                                    icon: Icons.access_time_outlined,
                                    text: AppFormat.hhmmDifference(
                                        _tableData.updatedAt!),
                                    defaultTextStyle: textStyle,
                                  )
                                : const SizedBox(),
                          )
                      ],
                    ),
                    if (_isOrderPatched) AppConst.dividerLineLight(height: 0.5),
                    if (_isOrderPatched)
                      Row(
                        children: [
                          Expanded(
                            child: _tableData.order?.finalTotal != null
                                ? tableRichText(
                                    icon: Icons.attach_money_outlined,
                                    text: AppFormat.doubleToStringUpTo2(
                                            _tableData.order?.finalTotal) ??
                                        '',
                                    defaultTextStyle: textStyle,
                                  )
                                : const SizedBox(),
                          ),
                          AppConst.dividerLineLight(height: 23, width: 0.5),
                          Expanded(
                            child: _tableData.order?.finalTotal != null
                                ? tableRichText(
                                    icon: Icons.payments_outlined,
                                    text: paymentStatusValues.reverse?[
                                            _tableData.order?.paymentStatus] ??
                                        '',
                                    defaultTextStyle: textStyle,
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Dropdown Button for Update/Change Table Status
        // if (_tableData.status != null)
        Positioned(
          top: 10,
          right: 10,
          // left: (TextDirection.ltr == true) ? 5 : 0,
          child: DropdownButton<TableStatus>(
            focusColor: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            underline: SizedBox(),
            items: tableStatusList(_tableData.status).map((TableStatus value) {
              return DropdownMenuItem<TableStatus>(
                value: value,
                child: Text('${value.name.toLowerCase().tr}'),
              );
            }).toList(),
            onChanged: (TableStatus? value) {
              debugPrint('$value');
              if (value != null)
                tableCtrlObj.changeTableStatus(_tableData.id, value);
            },
          ),
        ),
      ],
    );
  }

  Widget tableRichText(
          {IconData? icon, String? text, TextStyle? defaultTextStyle}) =>
      RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: defaultTextStyle ?? TextStyle(color: Colors.black),
          children: [
            if (icon != null)
              WidgetSpan(
                  child: Icon(icon, size: 18, color: defaultTextStyle?.color)),
            if (icon != null) TextSpan(text: ' '),
            TextSpan(text: text ?? '-'),
          ],
        ),
      );

  List<TableStatus> tableStatusList(TableStatus? tableStatusName) {
    List<TableStatus> _a = [
      TableStatus.FREE,
      TableStatus.BUSY,
      TableStatus.RESERVED,
    ];
    _a.removeWhere((element) => element == tableStatusName);
    return _a;
  }
}
