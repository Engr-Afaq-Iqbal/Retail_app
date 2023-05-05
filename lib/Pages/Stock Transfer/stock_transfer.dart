import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Components/textfield.dart';
import '../../Config/DateTimeFormat.dart';

class StockTransfer extends StatefulWidget {
  const StockTransfer({Key? key}) : super(key: key);

  @override
  State<StockTransfer> createState() => _StockTransferState();
}

class _StockTransferState extends State<StockTransfer> {
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController refCtrl = TextEditingController()
  Future<void> _showDatePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
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

    dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Transfer'),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: AppFormField(
                readOnly: true,
                controller: dateCtrl,
                labelText: 'select_date_range'.tr,
                prefixIcon: Icon(Icons.calendar_month),
                onTap: () {
                  setState(() {
                    _showDatePicker();

                    //_show(context);
                  });
                },
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: AppFormField(
                readOnly: true,
                controller: dateCtrl,
                labelText: 'Reference No.',
                //prefixIcon: Icon(Icons.calendar_month),
                onTap: () {
                  setState(() {
                    _showDatePicker();

                    //_show(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
