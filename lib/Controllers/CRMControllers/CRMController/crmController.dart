import 'package:bizmodo_emenu/Pages/CRM/Leads/allLeads.dart';
import 'package:get/get.dart';

import '../../../Pages/CRM/Campaigns/allCampaigns.dart';
import '../../../Pages/CRM/ContactsLogin/commissions.dart';
import '../../../Pages/CRM/ContactsLogin/contactsLogin.dart';
import '../../../Pages/CRM/FieldForce/fieldForce.dart';
import '../../../Pages/CRM/FollowUp/followUpTabsPage.dart';
import '../../../Pages/CRM/FollowUpCategory/allFollowUpCategory.dart';
import '../../../Pages/CRM/LifeStage/allLifeStage.dart';
import '../../../Pages/CRM/Proposal Template/proposalTemplate.dart';
import '../../../Pages/CRM/Proposals/AllProposals.dart';
import '../../../Pages/CRM/Reports/ReportsTabs/reportsTabsPage.dart';
import '../../../Pages/CRM/Settings/settingsCRM.dart';
import '../../../Pages/CRM/Source/allSource.dart';
import '../../../Pages/CustomesVisit/customersVisit.dart';

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
        'page' : FollowUpTabs(),
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
        'page' : Commissions(),
      },
      {
        'title' : 'Reports',
        'page' : ReportsTabsPage(),
      },
      {
        'title' : 'Proposal template',
        'page' : ProposalTemplate(),
      },
      {
        'title' : 'Proposals',
        'page' : AllProposals(),
      },
      {
        'title' : 'Sources',
        'page' : AllSource(),
      },
      {
        'title' : 'Life Stage',
        'page' : AllLifeStage(),
      },
      {
        'title' : 'Followup Category',
        'page' : AllFollowUpCategory(),
      },
      {
        'title' : 'Settings',
        'page' : SettingsCRM(),
      },
      {
        'title' : 'Field Force',
        'page' : FieldForce(),
      },
      {
        'title' : 'Visit',
        'page' : CustomerVisits(),
      },

    ];
    return options;
  }
}