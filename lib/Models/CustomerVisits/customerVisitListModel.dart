// To parse this JSON data, do
//
//     final customerVisitsListModel = customerVisitsListModelFromJson(jsonString);

import 'dart:convert';

CustomerVisitsListModel customerVisitsListModelFromJson(String str) =>
    CustomerVisitsListModel.fromJson(json.decode(str));

String customerVisitsListModelToJson(CustomerVisitsListModel data) =>
    json.encode(data.toJson());

class CustomerVisitsListModel {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  CustomerVisitsListModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CustomerVisitsListModel.fromJson(Map<String, dynamic> json) =>
      CustomerVisitsListModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  String name;
  String firstName;
  dynamic lastName;
  int id;
  int visiting;
  int contactId;
  String company;
  String visitingAddress;
  int userId;
  String visitOn;
  String purposeOfVisiting;
  String status;
  int businessId;
  dynamic reasonToNotMeetContact;
  dynamic photo;
  dynamic visitedOn;
  dynamic meetWith;
  dynamic meetWithMobileno;
  dynamic meetWithDesignation;
  dynamic meetWith2;
  dynamic meetWithMobileno2;
  dynamic meetWithDesignation2;
  dynamic meetWith3;
  dynamic meetWithMobileno3;
  dynamic meetWithDesignation3;
  dynamic visitedAddressLatitude;
  dynamic visitedAddressLongitude;
  dynamic visitedAddress;
  dynamic comments;
  DateTime createdAt;
  DateTime updatedAt;
  int createdBy;

  Datum({
    required this.name,
    required this.firstName,
    this.lastName,
    required this.id,
    required this.visiting,
    required this.contactId,
    required this.company,
    required this.visitingAddress,
    required this.userId,
    required this.visitOn,
    required this.purposeOfVisiting,
    required this.status,
    required this.businessId,
    this.reasonToNotMeetContact,
    this.photo,
    this.visitedOn,
    this.meetWith,
    this.meetWithMobileno,
    this.meetWithDesignation,
    this.meetWith2,
    this.meetWithMobileno2,
    this.meetWithDesignation2,
    this.meetWith3,
    this.meetWithMobileno3,
    this.meetWithDesignation3,
    this.visitedAddressLatitude,
    this.visitedAddressLongitude,
    this.visitedAddress,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        id: json["id"],
        visiting: json["visiting"] != null ? json["visiting"] : '',
        contactId: json["contact_id"],
        company: json["company"] != null ? json["company"] : '',
        visitingAddress:
            json["visiting_address"] != null ? json["visiting_address"] : '',
        userId: json["user_id"],
        visitOn: json["visit_on"] != null ? json["visit_on"] : '',
        purposeOfVisiting: json["purpose_of_visiting"] !=null ? json["purpose_of_visiting"] : '',
        status: json["status"] != null ? json["status"] : '',
        businessId: json["business_id"],
        reasonToNotMeetContact: json["reason_to_not_meet_contact"] != null
            ? json["reason_to_not_meet_contact"]
            : '',
        photo: json["photo"] != null ? json["photo"] : '',
        visitedOn: json["visited_on"] != null ? json["visited_on"] : '',
        meetWith: json["meet_with"] != null ? json["meet_with"] : '',
        meetWithMobileno: json["meet_with_mobileno"] != null
            ? json["meet_with_mobileno"]
            : '',
        meetWithDesignation: json["meet_with_designation"] != null
            ? json["meet_with_designation"]
            : '',
        meetWith2: json["meet_with2"] != null ? json["meet_with2"] : '',
        meetWithMobileno2: json["meet_with_mobileno2"] != null
            ? json["meet_with_mobileno2"]
            : '',
        meetWithDesignation2: json["meet_with_designation2"] != null
            ? json["meet_with_designation2"]
            : '',
        meetWith3: json["meet_with3"] != null ? json["meet_with3"] : '',
        meetWithMobileno3: json["meet_with_mobileno3"] != null
            ? json["meet_with_mobileno3"]
            : '',
        meetWithDesignation3: json["meet_with_designation3"] != null
            ? json["meet_with_designation3"]
            : '',
        visitedAddressLatitude: json["visited_address_latitude"] != null
            ? json["visited_address_latitude"]
            : '',
        visitedAddressLongitude: json["visited_address_longitude"] != null
            ? json["visited_address_longitude"]
            : '',
        visitedAddress:
            json["visited_address"] != null ? json["visited_address"] : '',
        comments: json["comments"] != null ? json["comments"] : '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "id": id,
        "visiting": visiting,
        "contact_id": contactId,
        "company": company,
        "visiting_address": visitingAddress,
        "user_id": userId,
        "visit_on": visitOn,
        "purpose_of_visiting": purposeOfVisiting,
        "status": status,
        "business_id": businessId,
        "reason_to_not_meet_contact": reasonToNotMeetContact,
        "photo": photo,
        "visited_on": visitedOn,
        "meet_with": meetWith,
        "meet_with_mobileno": meetWithMobileno,
        "meet_with_designation": meetWithDesignation,
        "meet_with2": meetWith2,
        "meet_with_mobileno2": meetWithMobileno2,
        "meet_with_designation2": meetWithDesignation2,
        "meet_with3": meetWith3,
        "meet_with_mobileno3": meetWithMobileno3,
        "meet_with_designation3": meetWithDesignation3,
        "visited_address_latitude": visitedAddressLatitude,
        "visited_address_longitude": visitedAddressLongitude,
        "visited_address": visitedAddress,
        "comments": comments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
