import 'package:get/get.dart';

import '../../../Pages/CRM/Leads/allLeads.dart';
import '../../../Pages/Repair/AddJobSheet/addJobSheet.dart';
import '../../../Pages/Repair/Brands/brands.dart';
import '../../../Pages/Repair/JobSheet/jobSheetTabs.dart';
import '../../../Pages/Repair/ListInvoices/listInvoicesTabs.dart';
import '../../../Pages/Repair/RepairSettings/repairSettings.dart';

class RepairController extends GetxController{

  String? repairStatus;
  List<Map<String, dynamic>> getRepairList() {
    List<Map<String, dynamic>> options = [
      {
        'title' : 'Job Sheets',
        'page' : JobSheetsTabs(),
      },
      {
        'title' : 'Add job sheet',
        'page' : AddJobSheet(),
      },
      {
        'title' : 'List Invoices',
        'page' : ListInvoicesTabs(),
      },
      {
        'title' : 'Add Invoice',
        'page' : Brands(),
      },
      {
        'title' : 'Brands',
        'page' : Brands(),
      },
      {
        'title' : 'Settings',
        'page' : RepairSettings(),
      },
    ];
    return options;
  }
}