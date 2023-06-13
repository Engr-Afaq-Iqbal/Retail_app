import 'package:flutter/material.dart';

import '../Theme/colors.dart';

class ProductHeadings extends StatelessWidget {
  final String? txt1;
  final String? txt2;
  final String? txt3;
  final String? txt4;
  ProductHeadings({Key? key, this.txt1, this.txt2, this.txt3, this.txt4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (txt1 != null)
            Expanded(
              flex: 2,
              child: Text(
                '${txt1}',
                style: TextStyle(color: kWhiteColor),
              ),
            ),
          if (txt2 != null)
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '${txt2}',
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ),
          if (txt3 != null)
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '${txt3}',
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ),
          if (txt4 != null)
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '${txt4}',
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
