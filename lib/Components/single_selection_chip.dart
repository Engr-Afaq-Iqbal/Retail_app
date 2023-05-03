import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Models/order_type_model/order_service_model.dart';

class SingleSelectionChip<T> extends StatefulWidget {
  final OrderServiceDataModel? initialData;
  final List<OrderServiceDataModel> chipsDataList;
  final ValueChanged<OrderServiceDataModel> valueChanged;
  final isHeadingAllowed;

  SingleSelectionChip({
    Key? key,
    this.initialData,
    required this.valueChanged,
    required this.chipsDataList,
    this.isHeadingAllowed = true,
  }) : super(key: key);

  @override
  _SingleSelectionChipState createState() => _SingleSelectionChipState();
}

class _SingleSelectionChipState extends State<SingleSelectionChip> {
  OrderServiceDataModel? initChoice;

  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.chipsDataList) {
      choices.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ChoiceChip(
            label: Text(
              '${item.name}'.tr,
              style: initChoice?.id == item.id
                  ? Theme.of(context)
                      .chipTheme
                      .labelStyle
                      ?.copyWith(color: Colors.white)
                  : null,
            ),
            selected: initChoice?.id == item.id,
            onSelected: (selected) {
              if (widget.isHeadingAllowed)
                setState(() {
                  print(selected);
                  print(item.id);
                  //print(widget.valueChanged(item));
                  initChoice = item;
                  widget.valueChanged(item);
                });
            },
          ),
        ),
      );
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    if (initChoice == null) initChoice = widget.initialData;
    return Wrap(
      alignment: WrapAlignment.center,
      children: _buildChoiceList(),
    );
  }
}
