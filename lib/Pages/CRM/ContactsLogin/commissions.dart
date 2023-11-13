import 'package:bizmodo_emenu/Controllers/CRMControllers/ContactsLogin/contactsLoginController.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'commissionsTile.dart';

class Commissions extends StatefulWidget {
  const Commissions({super.key});

  @override
  State<Commissions> createState() => _CommissionsState();
}

class _CommissionsState extends State<Commissions> {
  ScrollController? commissionsScroll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commissions'),
      ),
      body: Stack(
        children: [
          GetBuilder(
            builder: (ContactsLoginController contactsLoginCtrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  //await crmCtrl.callFirstOrderPage();
                },
                child: Scrollbar(
                  controller: commissionsScroll,
                  child: ListView.builder(
                    controller: commissionsScroll,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: CommissionsTile(),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          Positioned(
            bottom: 5,
            child: Container(
              padding: EdgeInsets.all(15),
              height: 50,
              width: MediaQuery.of(context).size.width,
            color: Colors.grey[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total:',style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(width: 30,),
                Text('0.00', style: TextStyle(fontSize: 16),)
              ],
            ),
            ),
          )
        ],
      ),
    );
  }
}
