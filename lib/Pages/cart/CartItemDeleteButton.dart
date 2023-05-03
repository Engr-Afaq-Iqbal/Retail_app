import 'package:flutter/material.dart';

class CartItemDeleteButton extends StatelessWidget {
  final Function()? onDeleteAction;
  const CartItemDeleteButton({this.onDeleteAction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDeleteAction,
      child: Icon(Icons.close_rounded, color: Colors.red),
    );
  }
}
