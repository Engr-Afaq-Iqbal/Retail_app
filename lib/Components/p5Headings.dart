import 'package:flutter/material.dart';

import '../Theme/colors.dart';

class Product5Headings extends StatelessWidget {
  final String? txt1;
  final String? txt2;
  final String? txt3;
  final String? txt4;
  final String? txt5;
  Product5Headings(
      {Key? key, this.txt1, this.txt2, this.txt3, this.txt4, this.txt5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (txt1 != null)
          Expanded(
            flex: 1,
            child: Text(
              '${txt1}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 12, fontWeight: FontWeight.bold, color: blackColor),
            ),
          ),
        if (txt2 != null)
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                '${txt2}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        if (txt3 != null)
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '${txt3}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        if (txt4 != null)
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '${txt4}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        if (txt5 != null)
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '${txt4}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
