import 'package:flutter/material.dart';

import '/Config/const.dart';

class PaymentStatusInfo extends StatelessWidget {
  final String? amount;
  final String? status;
  final Color? statusColor;
  const PaymentStatusInfo(this.amount, this.status, {this.statusColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          amount ?? '-',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12, color: Colors.black),
        ),
        AppConst.dividerLine(height: 12, width: 1),
        Text(
          status ?? '',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 12, color: statusColor ?? Colors.black),
        ),
      ],
    );
  }
}
