import 'package:flutter/material.dart';

import '/Theme/colors.dart';

class CounterWithAddRemoveButton extends StatelessWidget {
  final Function()? removeTabFun;
  final Function()? addTabFun;
  final String counter;
  const CounterWithAddRemoveButton(
      {Key? key, this.removeTabFun, this.addTabFun, required this.counter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: newOrderColor, width: 0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (removeTabFun != null)
            InkWell(
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
              onTap: removeTabFun,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                child: Icon(Icons.remove, color: newOrderColor, size: 16),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$counter',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
            ),
          ),
          if (addTabFun != null)
            InkWell(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              onTap: addTabFun,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                child: Icon(Icons.add, color: newOrderColor, size: 16),
              ),
            ),
        ],
      ),
    );
  }
}
