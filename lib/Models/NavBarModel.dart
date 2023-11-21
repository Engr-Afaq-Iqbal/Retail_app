import 'package:flutter/material.dart';

class NavBarModel {
  dynamic identifier;
  dynamic icon;
  String label;
  Function()? onTap;
  Widget page;
  NavBarModel({
    this.identifier,
    required this.icon,
    required this.label,
    this.onTap,
    required this.page,
  }) ;
}
