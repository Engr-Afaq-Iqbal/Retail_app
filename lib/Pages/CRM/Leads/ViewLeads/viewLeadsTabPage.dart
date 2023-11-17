import 'package:bizmodo_emenu/Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'package:flutter/material.dart';


class ViewLeadsTabs extends StatefulWidget {
  const ViewLeadsTabs({Key? key}) : super(key: key);
  @override
  _ViewLeadsTabsState createState() => _ViewLeadsTabsState();
}

class _ViewLeadsTabsState extends State<ViewLeadsTabs> {

  @override
  initState() {
    // loadOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LeadsController.viewLeadsTabsList().length,
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
                tabs:  LeadsController.viewLeadsTabsList().map((_orderTab) {
                  return Tab(text: _orderTab.label);
                }).toList(),
              ),
            ),
            Expanded(
              // child: OrdersListPage(),
              child: TabBarView(
                children:  LeadsController.viewLeadsTabsList()
                    .map((_orderTab) => _orderTab.page)
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
