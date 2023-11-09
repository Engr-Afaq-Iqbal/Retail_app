import 'package:bizmodo_emenu/Controllers/CRMControllers/CampaignsController/campaignsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addContactsLogin.dart';
import 'contactsLoginTile.dart';


class AllContactsLogin extends StatefulWidget {
  const AllContactsLogin({super.key});

  @override
  State<AllContactsLogin> createState() => _AllContactsLoginState();
}

class _AllContactsLoginState extends State<AllContactsLogin> {
  ScrollController? contactsLoginScroll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Contacts Login'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddContactsLogin());
          }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (CampaignsController campaignCtrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  //await crmCtrl.callFirstOrderPage();
                },
                child: Scrollbar(
                  controller: contactsLoginScroll,
                  child: ListView.builder(
                    controller: contactsLoginScroll,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: ContactsLoginTile(),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
