import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Controllers/AllSalesController/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Controllers/AllSalesController/allSalesController.dart';

class SalesTabPage extends StatefulWidget {
  const SalesTabPage({Key? key}) : super(key: key);
  @override
  _SalesTabPageState createState() => _SalesTabPageState();
}

class _SalesTabPageState extends State<SalesTabPage> {
  final AllSalesController _orderCtrlObj = Get.find<AllSalesController>();
  final QuotationController quotCtrl = Get.find<QuotationController>();
  @override
  initState() {
    // loadOrdersData();
    super.initState();
  }

  // loadOrdersData() async {
  //   if (_orderCtrlObj.allSaleOrdersPage == 1) {
  //     _orderCtrlObj.isFirstLoadRunning = true;
  //     await _orderCtrlObj.fetchSaleOrders(_orderCtrlObj.allSaleOrdersPage);
  //     _orderCtrlObj.isFirstLoadRunning = false;
  //   }
  // }

  ///Date time range picker
  Future<void> _showDateRangePicker() async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      type: OmniDateTimePickerType.dateAndTime,
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

    quotCtrl.startDateCtrl.text = dateTimeList![0].toString();
    quotCtrl.endDateCtrl.text = dateTimeList[1].toString();
    showProgress();
    quotCtrl.fetchListQuotations(
        start_date: quotCtrl.startDateCtrl.text,
        end_date: quotCtrl.endDateCtrl.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
        actions: [
          GestureDetector(
            onTap: () {
              _showDateRangePicker();
            },
            child: Icon(
              Icons.calendar_month_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: DefaultTabController(
        length: AllSalesController.stockTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  tabs: AllSalesController.stockTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children: AllSalesController.stockTabsList()
                      .map((_orderTab) => _orderTab.page != null ? _orderTab.page! : SizedBox(),)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
