import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffInfo extends StatelessWidget {
  final String? waiterName;
  const StaffInfo(this.waiterName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        'service_staff'.tr + ': ${waiterName?.capitalize ?? '-'}',
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 12,
              //fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
      ),
    );
  }
}
