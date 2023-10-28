import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../Theme/style.dart';
import '/Config/app_config.dart';

Future showAppOverlayBasic(
  BuildContext context,
  Widget topWidget, {
  bool autoRemove = true,
  Duration overlayDuration = const Duration(seconds: 2, milliseconds: 500),
}) async {
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) => topWidget);
  Overlay.of(context).insert(overlayEntry);

  if (autoRemove) {
    await Future.delayed(overlayDuration);
    overlayEntry.remove();
  }
}

showAppOverlayPre(
    {BuildContext? context,
    Widget? overlayBuilder,
    String? overlayTxtTitle,
    String? overlayTxtMsg}) {
  Widget _overlayContent = Card(
    margin: const EdgeInsets.all(5.0),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: overlayBuilder ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(overlayTxtTitle ?? '', style: AppStyles.overlayTitleStyle),
              if (overlayTxtMsg != null && overlayTxtMsg.isNotEmpty)
                Text(overlayTxtMsg ?? '', style: AppStyles.overlayMsgStyle),
            ],
          ),
    ),
  );

  return showOverlayNotification(
    (context) => Material(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _overlayContent,
        ],
      ),
    ),
    context: context,
    duration: Duration(seconds: 4),
  );
}
