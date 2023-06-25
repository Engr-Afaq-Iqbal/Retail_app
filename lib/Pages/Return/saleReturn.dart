import 'package:bizmodo_emenu/Components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Components/custom_circular_button.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Controllers/ProductController/product_cart_controller.dart';
import '../../Controllers/SalesReturnController/saleReturnController.dart';
import '../../Theme/colors.dart';
import '../SalesView/discount.dart';

class SalesReturn extends StatefulWidget {
  final String id;
  SalesReturn({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  final SaleReturnController saleReturnCtrlObj =
      Get.find<SaleReturnController>();
  final ProductCartController productCtrlCtrlObj =
      Get.find<ProductCartController>();

  Future<void> _showDatePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    saleReturnCtrlObj.saleReturnDateCtrl.text =
        '${AppFormat.dateDDMMYY(dateTime ?? DateTime.now())}';
    print(dateTime);
  }

  @override
  void initState() {
    print(widget.id);
    saleReturnCtrlObj.fetchEditSalesReturnList(id: widget.id);

    saleReturnCtrlObj.saleReturnDateCtrl.text =
        AppFormat.dateDDMMYY(DateTime.now()); // DateTime.now().toString();
    productCtrlCtrlObj.discoutCtrl.clear();
    // TODO: implement initState
    super.initState();
  }

  initialCtrl() async {
    var length =
        await saleReturnCtrlObj.editSaleReturnModelDart?.sellLines?.length ?? 0;
    print('length ;::::');
    print(length);
    for (int i = 0; i < length; i++) {
      saleReturnCtrlObj.returnQtyCtrl.add(TextEditingController());
    }
  }

  void dispose() {
    saleReturnCtrlObj.editSaleReturnModelDart = null;
    saleReturnCtrlObj.returnQtyCtrl.clear();
    saleReturnCtrlObj.totalReturnTax = '0.00';
    saleReturnCtrlObj.subtotal.clear();
    saleReturnCtrlObj.totalAmount = '0.00';
    // for (var controller in saleReturnCtrlObj.returnQtyCtrl) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Sale Return'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<SaleReturnController>(
                builder: (SaleReturnController saleReturnCtrl) {
              if (saleReturnCtrl.editSaleReturnModelDart == null)
                return progressIndicator();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Invoice No: ${saleReturnCtrl.editSaleReturnModelDart?.invoiceNo}'),
                  Text(
                      'Customer Name: ${saleReturnCtrl.editSaleReturnModelDart?.contact?.name}'),
                  Text(
                      'Date: ${saleReturnCtrl.editSaleReturnModelDart?.transactionDate}'),
                  SizedBox(
                    height: 10,
                  ),
                  AppFormField(
                    width: MediaQuery.of(context).size.width * 0.8,
                    readOnly: true,
                    controller: saleReturnCtrl.saleReturnDateCtrl,
                    labelText: 'Return Date',
                    prefixIcon: Icon(Icons.calendar_month),
                    onTap: () {
                      setState(() {
                        _showDatePicker();
                        //_show(context);
                      });
                    },
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Product Name',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Price',
                              style: TextStyle(color: kWhiteColor),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'QTY',
                              style: TextStyle(color: kWhiteColor),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Return QTY',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  // SaleReturnProductList(),
                  ListView.builder(
                      padding: EdgeInsetsDirectional.only(
                          top: 5, bottom: 5, start: 10, end: 10),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: saleReturnCtrl
                          .editSaleReturnModelDart?.sellLines?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          color: index.isEven
                              ? kWhiteColor
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '${saleReturnCtrl.editSaleReturnModelDart?.sellLines?[index].product?.name}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        AppFormat.doubleToStringUpTo2(
                                                '${saleReturnCtrl.editSaleReturnModelDart?.sellLines?[index].unitPrice}') ??
                                            '0.00',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '${saleReturnCtrl.editSaleReturnModelDart?.sellLines?[index].quantity}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppFormField(
                                      controller:
                                          saleReturnCtrl.returnQtyCtrl[index],
                                      padding: EdgeInsets.only(right: 5),
                                      isOutlineBorder: false,
                                      isColor: index.isEven
                                          ? kWhiteColor
                                          : Colors.transparent,
                                      onChanged: (value) {
                                        if (double.parse(saleReturnCtrl
                                                .returnQtyCtrl[index].text) >
                                            double.parse(
                                                '${saleReturnCtrl.editSaleReturnModelDart?.sellLines?[index].quantity}')) {
                                          showToast('Quantity not available');
                                          print('value is greater');
                                        } else {
                                          saleReturnCtrl.subtotal[index] =
                                              '${double.parse(value) * double.parse(saleReturnCtrl.editSaleReturnModelDart?.sellLines?[index].unitPrice ?? '0')}';
                                          saleReturnCtrl
                                              .totalTaxAmountWithDiscount(
                                                  ordersItemsTotalTax:
                                                      saleReturnCtrl
                                                          .totalOrderedTaxAmount(),
                                                  saleReturnCtrl:
                                                      saleReturnCtrl);
                                          saleReturnCtrl.returnTotalAmount();
                                          saleReturnCtrl.update();
                                        }
                                      },
                                      // onEditingComp: () {
                                      //
                                      // },
                                      // labelText: '1',
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Subtotal:- ${AppFormat.doubleToStringUpTo2(saleReturnCtrl.subtotal[index])}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.cancel_outlined,
                                  //   color: buttonColor,
                                  // )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          //title: title != null ? Text(title) : null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 0),
                          content: Discount(),
                        ),
                      );
                    },
                    bgColor: Theme.of(context).colorScheme.primary,
                    btnChild: Text(
                      'discount'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Total Return Discount:- ${productCtrlCtrlObj.discoutCtrl.text}'),
                  Text(
                      'Total Return Tax:- ${AppFormat.doubleToStringUpTo2(saleReturnCtrl.totalReturnTax)}'),
                  Text(
                      'Return Total Amount:- ${AppFormat.doubleToStringUpTo2(saleReturnCtrl.totalAmount)}'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        onTap: () async {
                          saleReturnCtrlObj.invoiceNbrCtrl.text =
                              '${saleReturnCtrlObj.editSaleReturnModelDart?.invoiceNo}';
                          saleReturnCtrlObj.transactionIdCtrl.text =
                              '${saleReturnCtrlObj.editSaleReturnModelDart?.id}';
                          print(saleReturnCtrlObj.invoiceNbrCtrl.text);
                          showProgress();
                          saleReturnCtrl.addSaleReturn();
                        },
                        bgColor: Theme.of(context).colorScheme.primary,
                        btnChild: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
