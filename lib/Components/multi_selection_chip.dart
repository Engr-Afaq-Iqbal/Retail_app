import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Models/ProductsModel/ProductVariationAndModifierModel.dart';
import '/Theme/colors.dart';

// Dynamic type custom widget
/*class MultiSelectChip<T> extends StatefulWidget {
  final List<T> chipsDataList;
  final Function(List<T>) onSelectionChanged;
  final String Function(T) itemTitle;
  final String Function(T) itemQuantity;
  final List<T> initChoices;

  MultiSelectChip({
    Key? key,
    required this.chipsDataList,
    required this.onSelectionChanged,
    required this.itemTitle,
    required this.itemQuantity,
    required this.initChoices,
  }) : super(key: key);
  @override
  _MultiSelectChipState<T> createState() => _MultiSelectChipState<T>();
}

class _MultiSelectChipState<T> extends State<MultiSelectChip<T>> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (T item in widget.chipsDataList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            ChoiceChip(
              label: Text(widget.itemTitle(item).capitalize!),
              selectedColor: primaryColor.withOpacity(0.25),
              selected: widget.initChoices.contains(item),
              onSelected: (selected) {
                setState(() {
                  if (widget.initChoices.contains(item)) {
                    widget.initChoices.remove(item);
                  } else {
                    widget.initChoices.add(item);
                  }
                  widget.onSelectionChanged(widget.initChoices); // +added
                });
              },
            ),
            if (widget.initChoices.contains(item))
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      widget.initChoices.;
                      widget.onSelectionChanged(widget.initChoices);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('${a}'),
                  ),
                  InkWell(
                    onTap: () {
                      widget.initChoices.add(item);
                      widget.onSelectionChanged(widget.initChoices);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}*/

class MultiSelectChip extends StatefulWidget {
  final List<VariationModel> chipsDataList;
  final Function(List<VariationModel>) onSelectionChanged;
  final List<VariationModel> initChoices;
  const MultiSelectChip({
    Key? key,
    required this.onSelectionChanged,
    required this.chipsDataList,
    this.initChoices = const <VariationModel>[],
  }) : super(key: key);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.chipsDataList) {
      choices.add(
        Padding(
          padding: const EdgeInsets.all(2.5),
          child: Column(
            children: [
              ChoiceChip(
                label: Text('${item.name.capitalize}'),
                selectedColor: primaryColor.withOpacity(0.25),
                selected: isContains(item.id),
                onSelected: (selected) {
                  setState(() {
                    if (isContains(item.id)) {
                      widget.initChoices.remove(item);
                    } else {
                      if (item.productVariationQuantity == 0) item.productVariationQuantity = 1;
                      widget.initChoices.add(item);
                    }
                    widget.onSelectionChanged(widget.initChoices);
                  });
                },
              ),
              // if (isContains(item.id))
              //   CounterWithAddRemoveButton(
              //     counter: '${item.productVariationQuantity}',
              //     removeTabFun: () {
              //       setState(() {
              //         if (item.productVariationQuantity > 1)
              //           item.productVariationQuantity--;
              //         else
              //           widget.initChoices.remove(item);
              //       });
              //       widget.onSelectionChanged(widget.initChoices);
              //     },
              //     addTabFun: () {
              //       setState(() {
              //         item.productVariationQuantity++;
              //       });
              //       widget.onSelectionChanged(widget.initChoices);
              //     },
              //   ),
            ],
          ),
        ),
      );
    }
    return choices;
  }

  isContains(int itemId) {
    return widget.initChoices.firstWhereOrNull((_choice) => _choice.id == itemId) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
