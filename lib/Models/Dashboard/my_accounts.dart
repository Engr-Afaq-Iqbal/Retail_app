import 'package:flutter/material.dart';

import '../../Theme/colors.dart';

class MyAccounts extends StatelessWidget {
   MyAccounts({super.key});
  final List<Map<String, dynamic>> items = [
    {'title': 'Item 1', 'trailingNumber': 100},
    {'title': 'Item 2', 'trailingNumber': 200},
    {'title': 'Item 3', 'trailingNumber': 300},
    {'title': 'Item 4', 'trailingNumber': 400},
    {'title': 'Item 5', 'trailingNumber': 500},
    {'title': 'Item 6', 'trailingNumber': 100},
    {'title': 'Item 7', 'trailingNumber': 200},
    {'title': 'Item 8', 'trailingNumber': 300},
    {'title': 'Item 9', 'trailingNumber': 400},
    {'title': 'Item 10', 'trailingNumber': 500},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Accounts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.numbers_outlined,  size: 16,),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Text(
                    "Account",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 13,
                      fontWeight: FontWeight.bold,),
                  ),
                ],
              ),
              Text("Balance", style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 13,
                fontWeight: FontWeight.bold,),),
            ],
        ),
          ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text((index + 1).toString()), // Leading number
                title: Text(items[index]['title']), // Title
                trailing: Text(
                    items[index]['trailingNumber'].toString()), // Trailing number
              );
            },
          ),
        ),
        ],
      ),
    ),);
  }
}
