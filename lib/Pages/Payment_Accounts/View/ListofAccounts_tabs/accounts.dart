import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Models/PaymentAccounts/list_accounts_model.dart';
import '../../../FundsTransfer/fundsTransfer.dart';
import '../../Controller/list_Accounts_controller.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final ListAccountsController controller = Get.find<ListAccountsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        if (controller.accountData.value.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: controller.accountData.value.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final Data account = controller.accountData.value.data![index];
              return Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                          ),
                          Text(
                            account.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Type",
                          ),
                          Text(
                            account.accountTypeId.toString() ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Sub Type",
                          ),
                          Text(
                            " param ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Number",
                          ),
                          Text(
                            account.accountNumber ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Note",
                          ),
                          Text(
                            account.note ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Balance",
                          ),
                          Text(
                            'balance param' + " د.إ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Added By",
                          ),
                          Text(
                            account.createdBy.toString() ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.book,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.money,
                            color: Colors.green,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.bottomSheet(FundTransfer(),
                              //     backgroundColor: Colors.white);
                              Get.to(FundsTransfer());
                            },
                            child: Icon(
                              Icons.attach_money,
                              color: Colors.green,
                            ),
                          ),
                          Icon(
                            Icons.power_settings_new,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .error,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}

class FundTransfer extends StatelessWidget {
  final ListAccountsController controller = Get.find<ListAccountsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transfer From"),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5.0,
                    child: DropdownButton<String?>(
                      items: controller.dropdownItems1.map((String? value) {
                        return DropdownMenuItem<String?>(
                          value: value,
                          child: Text(value ?? ''),
                        );
                      }).toList(),
                      value: controller.dropdownValue1,
                      onChanged: (newValue) {
                        controller.dropdownValue1 = newValue;
                      },
                      // Add dropdown items here
                    ),
                  ),
                ),
              ],
            ),
            Text("Transfer To"),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5.0,
                    child: DropdownButton<String?>(
                      underline: SizedBox(),
                      icon: SizedBox(),
                      items: controller.dropdownItems2.map((String? value) {
                        return DropdownMenuItem<String?>(
                          value: value,
                          child: Text(value ?? ''),
                        );
                      }).toList(),
                      value: controller.dropdownValue2,
                      onChanged: (newValue) {
                        controller
                          ..dropdownValue2 = newValue
                          ..update();
                      },
                      // Add dropdown items here
                    ),
                  ),
                ),
              ],
            ),
            Text("Amount"),
            Card(
              elevation: 5.0,
              child: TextField(

                controller: controller.textField1Controller.value,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Text("Note"),
            Card(
              elevation: 5.0,
              child: TextField(
                controller: controller.textField2Controller.value,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Text("Date"),
            Card(
              elevation: 5.0,
              child: TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null &&
                      pickedDate != controller.selectedDate.value) {
                    controller.selectedDate.value = pickedDate;
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Date'),
                    GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate != controller.selectedDate.value) {
                            controller.selectedDate.value = pickedDate;
                          }
                        },
                        child: Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implement file upload logic
                // You can use plugins like file_picker to handle file selection
              },
              child: Text('Upload File'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement submit logic
                    Get.back(); // Close bottom sheet
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close bottom sheet
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
