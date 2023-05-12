import 'package:flutter/material.dart';

import '../../Theme/colors.dart';
import 'AddSales.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor: primaryColor.withOpacity(0.5),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  child: AddSales(),
                );
              },
            );
          }),
      appBar: AppBar(
        title: Text('Sales'),
      ),
    );
  }
}
