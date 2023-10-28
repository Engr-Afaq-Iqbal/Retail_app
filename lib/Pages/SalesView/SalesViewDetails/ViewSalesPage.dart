import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/custom_circular_button.dart';
import '../../../Controllers/AllSalesController/allSalesController.dart';
import '../../../Controllers/ContactController/ContactController.dart';
import '../../../Controllers/ProductController/all_products_controller.dart';
import '../../../const/dimensions.dart';
import '../../CreateOrder/createOrderPage.dart';
import '../../PrintDesign/invoice_print_screen.dart';
import '../../PrintDesign/pdfGenerate.dart';
import '/Config/DateTimeFormat.dart';
import '/Config/const.dart';
import '/Models/order_type_model/SaleOrderModel.dart';
import '/Models/order_type_model/SellLineModel.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';

class SalesViewDetailsPage extends StatefulWidget {
  final SaleOrderDataModel? salesOrderData;
  SalesViewDetailsPage({Key? key, this.salesOrderData}) : super(key: key);

  @override
  State<SalesViewDetailsPage> createState() => _SalesViewDetailsPageState();
}

class _SalesViewDetailsPageState extends State<SalesViewDetailsPage> {
  final AllSalesController allSalesCtrl = Get.find<AllSalesController>();
  final ContactController contactCtrlObj = Get.find<ContactController>();
  final AllProductsController allProdCtrlObj =
  Get.find<AllProductsController>();
  @override
  void initState() {
    // TODO: implement initState
    ///Fetching product list before.

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('sale_order_details'.tr),
        actions: [
          CustomButton(
            onTap: () {
              allProdCtrlObj.editOrderFunction(widget.salesOrderData);
              allProdCtrlObj.updateOrderId = '${widget.salesOrderData?.id}';
              allProdCtrlObj.isUpdate = true;
              if (widget.salesOrderData?.totalPaid != null)
                allProdCtrlObj.paidAmount =
                    double.parse(widget.salesOrderData?.totalPaid ?? '0.00');
              allProdCtrlObj.update();
              contactCtrlObj.nameCtrl.text =
              '${widget.salesOrderData?.contact?.name ?? ''}';

              contactCtrlObj.contactId =
              '${widget.salesOrderData?.contact?.contactId ?? ''}';
              contactCtrlObj.id = '${widget.salesOrderData?.contact?.id ?? ''}';

              Get.to(CreateOrderPage(
                salesOrderData: widget.salesOrderData,
                isUpdate: true,
              ));
            },
            title: Text(
              'edit'.tr,
              style: TextStyle(color: kWhiteColor),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  '${widget.salesOrderData?.invoiceNo ?? ''}',
                  style: AppTextStyles.style13w500,
                ),
                // subtitle: Text(
                //   (order.serviceStaff?.firstName ?? '') +
                //       ' ' +
                //       (order.serviceStaff?.lastName ?? '') +
                //       ' | ${AppFormat.ddMMM12h(order.createdAt)}',
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline6!
                //       .copyWith(fontSize: 11.7, letterSpacing: 0.06),
                // ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppStyles.p2p5(
                    //   Row(
                    //     children: [
                    //       TableInfo(order.tableData?.name ?? ''),
                    //       AppConst.dividerLine(height: 10, width: 1),
                    //       StaffInfo(order.serviceStaff?.firstName ?? ''),
                    //     ],
                    //   ),
                    // ),
                    AppStyles.p2p5(CustomerInfo(
                        '${widget.salesOrderData?.contact?.name ?? ''}',
                        widget.salesOrderData?.transactionDate)),
                  ],
                ),
              ),
              Divider(color: Theme.of(context).cardColor, thickness: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('item'.tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xffadadad), fontWeight: FontWeight.bold)),
                ),
              ),
              AppStyles.p20h(itemsTable(context, index: 0, isHeading: true)),

              GetBuilder(builder: (AllSalesController allSalesCtrl) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.salesOrderData?.sellLines.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: GestureDetector(
                      onTap: () {
                        // orderCtrlObj.markUnMarkOrder(order.sellLines[index],
                        //     index: index);
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: itemsTable(context, index: index),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 5),
              Divider(color: Theme.of(context).cardColor, thickness: 8.0),
              Container(
                width: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  'payment'.tr.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: kDisabledColor, fontWeight: FontWeight.bold),
                ),
              ),

              AppConst.dividerLine(color: Theme.of(context).cardColor),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'sub_total_amount'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      AppFormat.doubleToStringUpTo2(
                        '${widget.salesOrderData?.totalBeforeTax ?? ''}',
                      ) ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // if (order.taxAmount != null)
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'tax_amount'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      AppFormat.doubleToStringUpTo2(
                        '${widget.salesOrderData?.taxAmount ?? ''}',
                      ) ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              //if (order.discountAmount != null)
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'discount'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      AppFormat.doubleToStringUpTo2(
                        '${widget.salesOrderData?.discountAmount ?? ''}',
                      ) ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // if (order.totalPaid != null)
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'paid_amount'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      AppFormat.doubleToStringUpTo2(
                          '${widget.salesOrderData?.totalPaid}') ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // if (order.finalTotal != null)
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'total_amount'.tr,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        AppFormat.doubleToStringUpTo2(
                          '${widget.salesOrderData?.finalTotal ?? ''}',
                        ) ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ]),
              ),
              AppConst.dividerLine(color: Theme.of(context).cardColor),
              // Due Amount
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'due_amount'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${AppFormat.doubleToStringUpTo2(double.parse('${double.parse('${widget.salesOrderData?.finalTotal ?? '0.00'}') - double.parse('${widget.salesOrderData?.totalPaid ?? '0.00'}')}').toString())}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ]),
              ),

              Divider(color: Theme.of(context).cardColor, thickness: 8.0),
              // Container(height: 180.0, color: Theme.of(context).cardColor),

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    leading: Icon(
                      Icons.print_outlined,
                      color: kWhiteColor,
                    ),
                    title: Text(
                      'print_invoice'.tr,
                      style: TextStyle(color: kWhiteColor),
                    ),
                    onTap: () {
                      print('Past Order Data');
                      Get.find<AllProductsController>().salesOrderModel =
                          widget.salesOrderData;
                      Get.dialog(Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall)),
                        insetPadding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: InVoicePrintScreen(),
                      ));
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButton(
                    leading: Icon(
                      Icons.picture_as_pdf_outlined,
                      color: kWhiteColor,
                    ),
                    title: Text(
                      'generate_pdf'.tr,
                      style: TextStyle(color: kWhiteColor),
                    ),
                    onTap: () {
                      print('Past Order Data');
                      // Get.dialog(Dialog(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //           Dimensions.radiusSmall)),
                      //   insetPadding:
                      //   EdgeInsets.all(Dimensions.paddingSizeSmall),
                      //   child: InVoicePrintScreen(),
                      // ));

                      Get.to(PrintData(
                        saleOrderDataModel: widget.salesOrderData,
                      ));
                    },
                  ),
                ],
              )
            ],
          )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ------------------- Staff Person with some reference
          // InkWell(
          //   onTap: () => Navigator.pushNamed(context, PageRoutes.track),
          //   child: Container(
          //     color: Theme.of(context).scaffoldBackgroundColor,
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         radius: 22.0,
          //         backgroundImage: AssetImage('assets/profile.jpg'),
          //       ),
          //       title: Text(
          //         'George Anderson',
          //         style: Theme.of(context)
          //             .textTheme
          //             .headline4!
          //             .copyWith(fontSize: 15.0, fontWeight: FontWeight.w500),
          //       ),
          //       subtitle: Text(
          //         'deliveryPartner'.tr,
          //         style: Theme.of(context)
          //             .textTheme
          //             .headline6!
          //             .copyWith(fontSize: 11.7, letterSpacing: 0.06),
          //       ),
          //       // trailing: IconButton(
          //       //   onPressed: () {},
          //       //   icon: Icon(
          //       //     Icons.navigation,
          //       //     color: kMainColor,
          //       //     size: 20.0,
          //       //   ),
          //       // ),
          //     ),
          //   ),
          // ),

          /// TODO: waiter application sy checkout counter application pr send krni hy.
          /// counter application pr notification pr tab krny sy specific order screen
          /// open krwa deni hy or us order k against counter pr betha person checkout complete kry ga.

          // Mark as Server Button
          // GetBuilder(builder: (OrderController orderCtrlObj) {
          //   return CustomButton(
          //     btnTxt: 'mark_served'.tr,
          //     borderRadius: 0,
          //     padding: const EdgeInsets.symmetric(vertical: 15),
          //     isBtnRounded: true,
          //     onTap: orderCtrlObj.updateOrderStatus,
          //   );
          //   // (isActiveOrder && orderCtrlObj.isAllOrderMarkedServed())
          //   //        ? CustomButton(
          //   //            btnTxt: 'notify'.tr,
          //   //            borderRadius: 0,
          //   //            padding: const EdgeInsets.symmetric(vertical: 15),
          //   //            isBtnRounded: true,
          //   //            onTap: orderCtrlObj.notifyReadyToCheckout,
          //   //          )
          //   //        : SizedBox.shrink();
          // }),
        ],
      ),
    );
  }

  itemsTable(BuildContext context,
      {required int index, bool isHeading = false}) {
    TextStyle? _headingTextStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.bold);

    return Row(
      children: [
        // Item Name
        Expanded(
          flex: 4,
          child: isHeading
              ? Text('product'.tr, style: _headingTextStyle)
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //order.sellLines[index].product?.name ?? '',
                '${widget.salesOrderData?.sellLines[index].product?.name ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              Text(
                // order.sellLines[index].product?.sku ?? '',
                '${widget.salesOrderData?.sellLines[index].product?.sku ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 12.0),
              ),
              // if (isActiveOrder)
              //   Text(
              //     lineOrderStatusValues.reverse?[
              //             order.sellLines[index].resLineOrderStatus] ??
              //         '',
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineMedium!
              //         .copyWith(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15.0,
              //           color: order.sellLines[index]
              //                       .resLineOrderStatusColorValue !=
              //                   null
              //               ? Color(order.sellLines[index]
              //                   .resLineOrderStatusColorValue!)
              //               : null,
              //         ),
              //   ),
            ],
          ),
        ),

        // Item Quantity
        Expanded(
          child: isHeading
              ? Text('qty'.tr.toUpperCase(), style: _headingTextStyle)
              : Text(
            //'${order.sellLines[index].quantity}',
            '${widget.salesOrderData?.sellLines[index].quantity ?? ''}',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
        ),

        /// TODO: all mark functionality implementation is remaining.
        // item selection / item price
        // (isActiveOrder &&
        //         (!Get.find<OrderController>().isOrderMarkedServed(index) &&
        //             !Get.find<OrderController>().isAllOrderMarkedServed()))
        //     // ? isItCooked(index)
        //     ? OrderSelectionBox(
        //         index: index, isHeading: isHeading, order: order)
        //     // : SizedBox()
        //     :
        Expanded(
          child: isHeading
              ? Text('price'.tr, style: _headingTextStyle)
              : Text(
            // AppFormat.doubleToStringUpTo2(
            //         order.sellLines[index].unitPriceIncTax) ??
            AppFormat.doubleToStringUpTo2(
              '${widget.salesOrderData?.sellLines[index].unitPrice ?? ''}',
            ) ??
                '0',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 13.3),
          ),
        ),

        //if (!isActiveOrder)
        isHeading
            ? Text('total'.tr, style: _headingTextStyle)
            : Text(
          AppFormat.doubleToStringUpTo2(
              '${double.parse(widget.salesOrderData?.sellLines[index].unitPrice ?? '0') * double.parse(widget.salesOrderData?.sellLines[index].quantity.toString() ?? '0')}') ??
              '0.00',
          // Get.find<ProductCartController>().totalItemPrice(
          //     order.sellLines[index].unitPriceIncTax,
          //     order.sellLines[index].quantity),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 13.3),
        ),
      ],
    );
  }
}

class OrderSelectionBox extends StatefulWidget {
  final int index;
  final bool isHeading;
  final SaleOrderDataModel order;
  final SellLine? sellLine;
  const OrderSelectionBox(
      {required this.order,
        this.sellLine,
        required this.index,
        this.isHeading = false,
        Key? key})
      : super(key: key);

  @override
  State<OrderSelectionBox> createState() => _OrderSelectionBoxState();
}

class _OrderSelectionBoxState extends State<OrderSelectionBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isHeading
          ? widget.order.sellLines.every((element) => element.isSelected)
          : widget.order.sellLines[widget.index].isSelected,
      onChanged: (_) {
        if (widget.isHeading)
          setState(() {
            Get.find<OrderController>().markUnMarkAllOrder(/*order.sellLines*/);
          });
        else
          setState(() {
            Get.find<OrderController>().markUnMarkOrder(
                widget.order.sellLines[widget.index],
                index: widget.index);
          });
      },
    );
  }
}
