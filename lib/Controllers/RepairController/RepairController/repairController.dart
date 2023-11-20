import 'package:get/get.dart';

import '../../../Pages/CRM/Leads/allLeads.dart';
import '../../../Pages/Repair/AddJobSheet/addJobSheet.dart';
import '../../../Pages/Repair/JobSheet/jobSheetTabs.dart';

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
        'page' : AllLeads(),
      },
      {
        'title' : 'Add Invoice',
        'page' : AllLeads(),
      },
      {
        'title' : 'Brands',
        'page' : AllLeads(),
      },
      {
        'title' : 'Settings',
        'page' : AllLeads(),
      },
    ];
    return options;
  }
}