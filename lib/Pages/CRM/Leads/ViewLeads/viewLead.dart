import 'package:bizmodo_emenu/Pages/CRM/Leads/ViewLeads/viewLeadsTabPage.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';


class ViewLead extends StatefulWidget {
  const ViewLead({super.key});

  @override
  State<ViewLead> createState() => _ViewLeadState();
}

class _ViewLeadState extends State<ViewLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Lead'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: 2,
                      color: Colors.grey.withOpacity(0.2)
                    )
                  ]
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Icon(Icons.person_2_outlined,size: 30,)),
                      Center(
                        child: Text(
                          'Mr Afaq Iqbal',
                         style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                        ),
                      ),
                      iconWithText(
                          icon: Icons.location_on_outlined,
                          txt:  'Address'),
                      SizedBox(height: 5,),
                      Text(
                        'H#1132',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith( color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 10,),
                      iconWithText(
                          icon: Icons.mobile_friendly_outlined,
                      txt:  'Mobile'),
                      SizedBox(height: 5,),
                      Text(
                        'H#1132',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith( color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 10,),
                      iconWithText(
                          icon: Icons.calendar_today_outlined,
                          txt:  'Date of Birth'),
                      SizedBox(height: 5,),
                      Text(
                        '11/11/2023',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith( color: Colors.black, fontSize: 14),
                      ),

                      SizedBox(height: 10,),
                      iconWithText(
                          icon: Icons.info_outline,
                          txt:  'Tax number'),
                      SizedBox(height: 5,),
                      Text(
                        '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith( color: Colors.black, fontSize: 14),
                      ),

                      SizedBox(height: 10,),
                      iconWithText(
                          icon: Icons.person_sharp,
                          txt:  'Assigned To'),
                      SizedBox(height: 5,),
                      Text(
                        'Haseeb Bin Umer',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith( color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor
                        ),
                        child: Text(
                          'Add Discount',
                          style: TextStyle(color: kWhiteColor),
                        ),
                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ViewLeadsTabs()),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconWithText({
    IconData? icon,
    String? txt,
}) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 3,),
        Text(
         '$txt',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}



