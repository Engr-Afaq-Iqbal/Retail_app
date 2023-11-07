import 'package:flutter/material.dart';

import '../../../Config/DateTimeFormat.dart';

class BodyHeadingTile extends StatelessWidget {
  final String? heading;
  final String? body;
  const BodyHeadingTile({this.heading, this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$heading',
         style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 11.7),
        ),
        SizedBox(width: 5),
        Text(
          '$body',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 11.7, letterSpacing: 0.06, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
