import 'package:bizmodo_emenu/Controllers/RepairController/ListInvoicesController/listInvoicesController.dart';
import 'package:flutter/material.dart';


class ListInvoicesTabs extends StatefulWidget {
  const ListInvoicesTabs({Key? key}) : super(key: key);
  @override
  _ListInvoicesTabsState createState() => _ListInvoicesTabsState();
}

class _ListInvoicesTabsState extends State<ListInvoicesTabs> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),

      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.small(
      //     child: Icon(Icons.add),
      //     backgroundColor:
      //     Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //     onPressed: () {
      //       Get.to(AddJobSheet());
      //     }),
      body: DefaultTabController(
        length: ListInvoicesController.listInvoicesTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2, // Adjust the thickness of the underline
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Color of the underline
                    ),
                  ),
                  automaticIndicatorColorAdjustment: true,
                  tabs:  ListInvoicesController.listInvoicesTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children:  ListInvoicesController.listInvoicesTabsList()
                      .map((_orderTab) => _orderTab.page)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
