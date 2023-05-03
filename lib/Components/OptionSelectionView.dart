import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionSelectionView<T> extends StatelessWidget {
  final int? itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Color? bgColor;
  final double? width;
  const OptionSelectionView(
      {this.itemCount,
      required this.itemBuilder,
      this.width,
      this.bgColor = Colors.transparent,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}

class OptionSelectionTile extends StatelessWidget {
  final int itemCount;
  final Function()? onTap;
  final String? tileTitle;
  const OptionSelectionTile(
      {this.onTap, this.tileTitle, Key? key, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          //  tileColor: ,
          onTap: () {
            if (onTap != null) onTap!();
            Get.back();
          },
          title: Text(tileTitle ?? ''),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
