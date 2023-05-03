// // To parse this JSON data, do
// //
// //     final notificationShowingModel = notificationShowingModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NotificationShowingModel notificationShowingModelFromJson(String str) =>
//     NotificationShowingModel.fromJson(json.decode(str));
//
// String notificationShowingModelToJson(NotificationShowingModel data) =>
//     json.encode(data.toJson());
//
// class NotificationShowingModel {
//   List<Datum>? data;
//
//   NotificationShowingModel({
//     this.data,
//   });
//
//   factory NotificationShowingModel.fromJson(Map<String, dynamic> json) =>
//       NotificationShowingModel(
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   String? msg;
//   IconClass? iconClass;
//   String? link;
//   DateTime? readAt;
//   String? createdAt;
//   bool? showPopup;
//
//   Datum({
//     this.msg,
//     this.iconClass,
//     this.link,
//     this.readAt,
//     this.createdAt,
//     this.showPopup,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         msg: json["msg"] == null ? null : json["msg"],
//         iconClass: iconClassValues.map[json["icon_class"]]!,
//         link: json["link"],
//         readAt:
//             json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
//         createdAt: json["created_at"] == null ? null : json["created_at"],
//         showPopup: json["show_popup"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "msg": msgValues.reverse[msg],
//         "icon_class": iconClassValues.reverse[iconClass],
//         "link": link,
//         "read_at": readAt?.toIso8601String(),
//         "created_at": createdAtValues.reverse[createdAt],
//         "show_popup": showPopup,
//       };
// }
//
// enum CreatedAt {
//   THE_18_MINUTES_AGO,
//   THE_19_HOURS_AGO,
//   THE_20_HOURS_AGO,
//   THE_23_HOURS_AGO,
//   THE_1_DAY_AGO,
//   THE_5_DAYS_AGO,
//   THE_6_DAYS_AGO,
//   THE_1_WEEK_AGO,
//   THE_2_WEEKS_AGO,
//   THE_3_WEEKS_AGO,
//   THE_1_MONTH_AGO,
//   THE_2_MONTHS_AGO,
//   THE_5_MONTHS_AGO
// }
//
// final createdAtValues = EnumValues({
//   "18 minutes ago": CreatedAt.THE_18_MINUTES_AGO,
//   "19 hours ago": CreatedAt.THE_19_HOURS_AGO,
//   "1 day ago": CreatedAt.THE_1_DAY_AGO,
//   "1 month ago": CreatedAt.THE_1_MONTH_AGO,
//   "1 week ago": CreatedAt.THE_1_WEEK_AGO,
//   "20 hours ago": CreatedAt.THE_20_HOURS_AGO,
//   "23 hours ago": CreatedAt.THE_23_HOURS_AGO,
//   "2 months ago": CreatedAt.THE_2_MONTHS_AGO,
//   "2 weeks ago": CreatedAt.THE_2_WEEKS_AGO,
//   "3 weeks ago": CreatedAt.THE_3_WEEKS_AGO,
//   "5 days ago": CreatedAt.THE_5_DAYS_AGO,
//   "5 months ago": CreatedAt.THE_5_MONTHS_AGO,
//   "6 days ago": CreatedAt.THE_6_DAYS_AGO
// });
//
// enum IconClass { EMPTY, FAS_FA_EXCLAMATION_TRIANGLE_BG_YELLOW }
//
// final iconClassValues = EnumValues({
//   "": IconClass.EMPTY,
//   "fas fa-exclamation-triangle bg-yellow":
//       IconClass.FAS_FA_EXCLAMATION_TRIANGLE_BG_YELLOW
// });
//
// enum Msg {
//   YOU_HAVE_A_NEW_ORDER,
//   PAYMENT_SUBMIT_SUCCESSFULLY,
//   ORDER_HAS_BEEN_CANCELLED,
//   NEW_MESSAGE_FROM_SUPERADMIN
// }
//
// final msgValues = EnumValues({
//   "New message from superadmin": Msg.NEW_MESSAGE_FROM_SUPERADMIN,
//   "Order has been Cancelled!": Msg.ORDER_HAS_BEEN_CANCELLED,
//   "Payment Submit Successfully!": Msg.PAYMENT_SUBMIT_SUCCESSFULLY,
//   "You have a New Order!": Msg.YOU_HAVE_A_NEW_ORDER
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final notificationShowingModel = notificationShowingModelFromJson(jsonString);

import 'dart:convert';

NotificationShowingModel notificationShowingModelFromJson(String str) =>
    NotificationShowingModel.fromJson(json.decode(str));

String notificationShowingModelToJson(NotificationShowingModel data) =>
    json.encode(data.toJson());

class NotificationShowingModel {
  List<Datum>? data;

  NotificationShowingModel({
    this.data,
  });

  factory NotificationShowingModel.fromJson(Map<String, dynamic> json) =>
      NotificationShowingModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? msg;
  IconClass? iconClass;
  String? link;
  DateTime? readAt;
  String? createdAt;
  bool? showPopup;

  Datum({
    this.id,
    this.msg,
    this.iconClass,
    this.link,
    this.readAt,
    this.createdAt,
    this.showPopup,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        msg: json["msg"] == null ? null : json["msg"],
        iconClass: iconClassValues.map[json["icon_class"]]!,
        link: json["link"],
        readAt:
            json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        showPopup: json["show_popup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "msg": msgValues.reverse[msg],
        "icon_class": iconClassValues.reverse[iconClass],
        "link": link,
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAtValues.reverse[createdAt],
        "show_popup": showPopup,
      };
}

enum CreatedAt {
  THE_22_HOURS_AGO,
  THE_1_DAY_AGO,
  THE_2_DAYS_AGO,
  THE_6_DAYS_AGO,
  THE_1_WEEK_AGO,
  THE_2_WEEKS_AGO,
  THE_3_WEEKS_AGO,
  THE_1_MONTH_AGO,
  THE_2_MONTHS_AGO,
  THE_3_MONTHS_AGO,
  THE_6_MONTHS_AGO
}

final createdAtValues = EnumValues({
  "1 day ago": CreatedAt.THE_1_DAY_AGO,
  "1 month ago": CreatedAt.THE_1_MONTH_AGO,
  "1 week ago": CreatedAt.THE_1_WEEK_AGO,
  "22 hours ago": CreatedAt.THE_22_HOURS_AGO,
  "2 days ago": CreatedAt.THE_2_DAYS_AGO,
  "2 months ago": CreatedAt.THE_2_MONTHS_AGO,
  "2 weeks ago": CreatedAt.THE_2_WEEKS_AGO,
  "3 months ago": CreatedAt.THE_3_MONTHS_AGO,
  "3 weeks ago": CreatedAt.THE_3_WEEKS_AGO,
  "6 days ago": CreatedAt.THE_6_DAYS_AGO,
  "6 months ago": CreatedAt.THE_6_MONTHS_AGO
});

enum IconClass { EMPTY, FAS_FA_EXCLAMATION_TRIANGLE_BG_YELLOW }

final iconClassValues = EnumValues({
  "": IconClass.EMPTY,
  "fas fa-exclamation-triangle bg-yellow":
      IconClass.FAS_FA_EXCLAMATION_TRIANGLE_BG_YELLOW
});

enum Msg {
  YOU_HAVE_A_NEW_ORDER,
  PAYMENT_SUBMIT_SUCCESSFULLY,
  ORDER_HAS_BEEN_CANCELLED,
  NEW_MESSAGE_FROM_SUPERADMIN
}

final msgValues = EnumValues({
  "New message from superadmin": Msg.NEW_MESSAGE_FROM_SUPERADMIN,
  "Order has been Cancelled!": Msg.ORDER_HAS_BEEN_CANCELLED,
  "Payment Submit Successfully!": Msg.PAYMENT_SUBMIT_SUCCESSFULLY,
  "You have a New Order!": Msg.YOU_HAVE_A_NEW_ORDER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
