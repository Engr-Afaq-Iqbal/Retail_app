import 'package:get/get.dart';

import '/Models/enum_value_model.dart';

// Application Screen enum
enum OrderProcessScreen { ServiceSelectionPage, TableSelectionPage, CartPage }

// Tax enum
enum ProductTaxName { VAT }

final productTaxNameValues = EnumValues({"VAT": ProductTaxName.VAT});

// Tax Type enum
enum TaxType { INCLUSIVE }

final taxTypeValues = EnumValues({"inclusive": TaxType.INCLUSIVE});

// Contact Status
enum ContactStatus { ACTIVE, INACTIVE }

final contactStatusValues = EnumValues(
    {"active": ContactStatus.ACTIVE, "in_active": ContactStatus.INACTIVE});

// Contact Type
enum ContactType { CUSTOMER, SUPPLIER, BOTH }

final contactTypeValues = EnumValues({
  "customer": ContactType.CUSTOMER,
  "supplier": ContactType.SUPPLIER,
  "both": ContactType.BOTH
});

// T Type
enum TType { PERCENTAGE, FIXED }

final tTypeValues =
    EnumValues({'percentage'.tr: TType.PERCENTAGE, 'fixed'.tr: TType.FIXED});

// Payment Status
enum PaymentStatus { PAID, DUE, PARTIAL }

final paymentStatusValues = EnumValues<PaymentStatus>({
  'due'.tr: PaymentStatus.DUE,
  'paid'.tr: PaymentStatus.PAID,
  'partial'.tr: PaymentStatus.PARTIAL
});

final paymentStatusColors = EnumValues<PaymentStatus>({
  "0xffffc107": PaymentStatus.DUE,
  "0xff98D973": PaymentStatus.PAID,
  "0xff11cdef": PaymentStatus.PARTIAL
});

// Recur Interval Type
enum RecurIntervalType { DAYS }

final recurIntervalTypeValues = EnumValues({"days": RecurIntervalType.DAYS});

// Children Type
enum ChildrenType { EMPTY, MODIFIER }

final childrenTypeValues =
    EnumValues({"": ChildrenType.EMPTY, "modifier": ChildrenType.MODIFIER});

// Status
enum Status { FINAL, DRAFT }

final statusValues = EnumValues({"draft": Status.DRAFT, "final": Status.FINAL});

// Datum Type
enum DatumType { SELL }

final datumTypeValues = EnumValues({"sell": DatumType.SELL});

// Type
enum Type { FIXED }

final typeValues = EnumValues({"fixed": Type.FIXED});

// Table Status
enum TableStatus { FREE, BUSY, RESERVED }

final EnumValues<TableStatus> tableStatusValues = EnumValues<TableStatus>(
  {
    'Busy': TableStatus.BUSY,
    'Free': TableStatus.FREE,
    'Reserved': TableStatus.RESERVED
  },
);

// Line Order Status
enum LineOrderStatus { PENDING, COOKED, SERVED }

final EnumValues<LineOrderStatus> lineOrderStatusValues =
    EnumValues<LineOrderStatus>(
  {
    "Pending": LineOrderStatus.PENDING,
    "Cooked": LineOrderStatus.COOKED,
    "Served": LineOrderStatus.SERVED
  },
);

// final EnumValues<LineOrderStatus> lineOrderStatusColor = EnumValues<LineOrderStatus>(
//   {
//     LineOrderStatus.PENDING: ffc107,
//     LineOrderStatus.COOKED: ,
//     LineOrderStatus.SERVED: ,
//   },
// );

// Order Status
enum OrderStatus {
  PACKED,
  SHIPPED,
  PENDING,
  ORDERED,
  COOKED,
  SERVED,
  PARTIAL,
  CANCELLED,
  DELIVERED,
  COMPLETED
}

final EnumValues<OrderStatus> orderStatusValues = EnumValues<OrderStatus>(
  {
    "Packed": OrderStatus.PACKED,
    "Shipped": OrderStatus.SHIPPED,
    "Pending": OrderStatus.PENDING,
    "Ordered": OrderStatus.ORDERED,
    "Cooked": OrderStatus.COOKED,
    "Served": OrderStatus.SERVED,
    "Partial": OrderStatus.PARTIAL,
    "Cancelled": OrderStatus.CANCELLED,
    "Delivered": OrderStatus.DELIVERED,
    "Completed": OrderStatus.COMPLETED
  },
);

final EnumValues<OrderStatus> orderStatusColors = EnumValues<OrderStatus>(
  {
    "0xff00c0ef": OrderStatus.PACKED,
    "0xff001f3f": OrderStatus.SHIPPED,
    "0xffffc107": OrderStatus.PENDING,
    "0xffffc107": OrderStatus.ORDERED,
    "0xfff5365c": OrderStatus.COOKED,
    "0xff98D973": OrderStatus.SERVED,
    "0xff11cdef": OrderStatus.PARTIAL,
    "0xfff5365c": OrderStatus.CANCELLED,
    "0xff2dce89": OrderStatus.DELIVERED,
    "0xff2dce89": OrderStatus.COMPLETED
  },
);
