import 'package:flutter/material.dart';

class AmountTile extends StatelessWidget {
  final String? title;
  final String trailValue;
  const AmountTile({this.title, required this.trailValue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          if (title != null)
            Text(
              title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14),
            ),
          Expanded(
            child: Text(
              trailValue,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
