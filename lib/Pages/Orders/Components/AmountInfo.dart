import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:flutter/material.dart';

class AmountInfo extends StatelessWidget {
  final String? amount;
  final String? status;
  const AmountInfo({this.amount, this.status, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.payments_outlined,
          size: 15,
        ),
        SizedBox(width: 5),
        Text(
          AppFormat.doubleToStringUpTo2(amount) ?? '-',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 11.7, letterSpacing: 0.06, color: Colors.black),
        ),
        SizedBox(width: 5),
        Text(
          status ?? '',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 11.7, letterSpacing: 0.06, color: Colors.black),
        ),
      ],
    );
  }
}
