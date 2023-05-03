import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/DateTimeFormat.dart';
import '/Config/const.dart';

class CustomerInfo extends StatelessWidget {
  final String? customerName;
  final DateTime? bookingDate;
  const CustomerInfo(this.customerName, this.bookingDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, size: 15),
        Text(
          customerName?.capitalize ?? '-',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12, color: Colors.black),
        ),
        AppConst.dividerLine(height: 12, width: 1),
        Text(
          AppFormat.ddMMM12h(bookingDate) ?? '',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 12,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
