import 'package:bizmodo_emenu/Pages/CRM/Leads/allLeads.dart';
import 'package:get/get.dart';

import '../../../Pages/CRM/Campaigns/allCampaigns.dart';
import '../../../Pages/CRM/ContactsLogin/contactsLogin.dart';

class CRMController extends GetxController{

  String? crmStatus;
  List<Map<String, dynamic>> getCRMList() {
    List<Map<String, dynamic>> options = [
      {
        'title' : 'Leads',
        'page' : AllLeads(),
      },
      {
        'title' : 'Follow ups',
        'page' : AllLeads(),
      },
      {
        'title' : 'Campaigns',
        'page' : AllCampaigns(),
      },
      {
        'title' : 'Contacts Login',
        'page' : AllContactsLogin(),
      },
      {
        'title' : 'Commission',
        'page' : AllLeads(),
      },
      {
        'title' : 'Reports',
        'page' : AllLeads(),
      },
      {
        'title' : 'Proposal template',
        'page' : AllLeads(),
      },
      {
        'title' : 'Proposals',
        'page' : AllLeads(),
      },
      {
        'title' : 'Sources',
        'page' : AllLeads(),
      },
      {
        'title' : 'Life Stage',
        'page' : AllLeads(),
      },
      {
        'title' : 'Followup Category',
        'page' : AllLeads(),
      },
      {
        'title' : 'Settings',
        'page' : AllLeads(),
      },
      {
        'title' : 'Field Force',
        'page' : AllLeads(),
      },
      {
        'title' : 'Visit',
        'page' : AllLeads(),
      },

    ];
    return options;
  }
}