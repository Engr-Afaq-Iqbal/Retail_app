import 'package:flutter/material.dart';

class Commissions extends StatefulWidget {
  const Commissions({super.key});

  @override
  State<Commissions> createState() => _CommissionsState();
}

class _CommissionsState extends State<Commissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commissions'),
      ),
    );
  }
}
