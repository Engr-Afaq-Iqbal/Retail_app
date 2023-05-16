import 'package:bizmodo_emenu/Components/textfield.dart';
import 'package:bizmodo_emenu/Pages/Return/saleReturnProductsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Components/custom_circular_button.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Controllers/SalesReturnController/saleReturnController.dart';
import '../../Theme/colors.dart';
import '../SalesView/discount.dart';

class SalesReturn extends StatefulWidget {
  const SalesReturn({Key? key}) : super(key: key);

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  final SaleReturnController saleReturnCtrlObj =
      Get.find<SaleReturnController>();

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

    saleReturnCtrlObj.saleReturnDateCtrl.text =
        '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Return'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice No: INV88189'),
              Text('Customer Name: Afaq'),
              Text('Date: 05/03/2023'),
              AppFormField(
                width: MediaQuery.of(context).size.width * 0.43,
                readOnly: true,
                controller: saleReturnCtrlObj.saleReturnDateCtrl,
                labelText: 'Return Date',
                prefixIcon: Icon(Icons.calendar_month),
                onTap: () {
                  setState(() {
                    _showDatePicker();

                    //_show(context);
                  });
                },
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Product Name',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Price',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'QTY',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Return QTY',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    )
                  ],
                ),
              ),
              SaleReturnProductList(),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      //title: title != null ? Text(title) : null,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 0),
                      content: Discount(),
                    ),
                  );
                },
                bgColor: primaryColor,
                btnChild: Text(
                  'discount'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Total Return Discount:-'),
              Text('Total Return Tax:-'),
              Text('Return Total Amount:-'),
            ],
          ),
        ),
      ),
    );
  }
}
