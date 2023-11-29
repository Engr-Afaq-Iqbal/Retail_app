import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/List_Accounts.dart';

class PaymentAccounts extends StatefulWidget {
  const PaymentAccounts({super.key});

  @override
  State<PaymentAccounts> createState() => _PaymentAccountsState();
}

class _PaymentAccountsState extends State<PaymentAccounts> {
  String selectedOption = 'Head';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('payment_account_view'.tr),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<String>(
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
                items: <String>['Head', 'Torso', 'Legs', 'Arms']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(child: _getBodyView(selectedOption)),
        ],
      ),
    );
  }
  Widget _getBodyView(String selectedOption) {
    switch (selectedOption) {
      case 'Head':
        return ListAccountsTabPage();
      case 'Torso':
        return Image.asset(
          'assets/torso.png', // Replace with actual image path
          height: 200,
        );
      case 'Legs':
        return Image.asset(
          'assets/legs.png', // Replace with actual image path
          height: 200,
        );
      case 'Arms':
        return Image.asset(
          'assets/arms.png', // Replace with actual image path
          height: 200,
        );
      default:
        return Container(); // Placeholder for default case
    }
  }
}
