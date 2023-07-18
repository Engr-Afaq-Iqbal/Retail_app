import 'package:flutter/cupertino.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

import '../../Config/utils.dart';
import '../../Models/AllPrinterModel/AllPrinterModels.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Pages/PrintDesign/pos_print_layout.dart';
import '../../Services/storage_services.dart';

class AllPrinterController extends GetxController {
  final PrinterManager printerManager = PrinterManager.instance;

  /// Data variable for Printing
  SaleOrderDataModel? orderDataForPrinting;

  bool isPrinterNameReceipt(String? printerName) {
    if (printerName == null) return false;
    return printerName.toLowerCase() == 'recipe' ||
        printerName.toLowerCase() == 'receipt';
  }

  /// Printer Connection/ Disconnection and printing
  BluetoothPrinter? selectedPrinter;
  BluetoothPrinter setNetworkPrinterIpAddress(
      {required String deviceName, required String address, String? port}) {
    BluetoothPrinter device = BluetoothPrinter(
      deviceName: deviceName,
      address: address,
      port: port ?? '9100',
      typePrinter: PrinterType.network,
      state: false,
    );
    debugPrint(
        '-----\nIP Address set. IP => ${device.address}, Port => ${device.port}');
    return device;
  }

  Future<void> _disconnectDevice(BluetoothPrinter device) async {
    try {
      if (selectedPrinter != null) {
        if (device.address != selectedPrinter!.address) {
          debugPrint('Disconnect Printer. ${selectedPrinter?.address}');
          await PrinterManager.instance
              .disconnect(type: selectedPrinter!.typePrinter);
        }
      }
    } catch (e) {
      debugPrint('_disconnectDevice -> AppPrinterController => $e');
    }
  }

  Future<void> selectDevice(BluetoothPrinter device) async {
    await _disconnectDevice(device);

    selectedPrinter = device;
    debugPrint(
        'select Device -> Selected Printer => ${selectedPrinter?.address}\n-----');
  }

  /// Create Order Invoice
  Future printInvoiceOfOrder(
      {bool isAutoPrintingOnly = true,
      bool printOnlyNonAuto = false,
      bool isCreateOrder = false,
      bool generatePdf = false}) async {
    print('inside printing 2nd function');

    Future<AllPrintersModel?> extractInvoicePrinterAndPrintOrder() async {
      debugPrint('Print Invoice of Created Order!');

      try {
        // find default printer and extract printer details (decided that, default printer name should be receipt/recipe )
        AllPrintersModel? invoiceDefaultPrinterInfo =
            AppStorage.getPrinterData()?.firstWhereOrNull(
                (element) => isPrinterNameReceipt(element.name));

        bool isInvoiceDefaultPrinterEnabled = false;

        // check invoice auto print enabled or not for default printer
        if (invoiceDefaultPrinterInfo != null) {
          isInvoiceDefaultPrinterEnabled = isCreateOrder
              ? invoiceDefaultPrinterInfo.isEnableCreateOrderInvoiceAutoPrint
              : invoiceDefaultPrinterInfo.isEnableCheckoutOrderInvoiceAutoPrint;
        }

        // assign printer if auto printing of default printer enabled
        // agr Auto Printer ke request receive hui hy or current iteration pr item k against printer ke auto printing b enabled hy to
        if (isInvoiceDefaultPrinterEnabled) {
          return invoiceDefaultPrinterInfo;
        }
        // printer selection option in any case like default printer not available or default printer auto printing not enabled
        // agr Non Auto Printer ke request receive hui hy or current iteration pr item k against printer ke auto printing disabled hy to
        else if (!isAutoPrintingOnly || !isInvoiceDefaultPrinterEnabled) {
          return AppStorage.getPrinterData()?.firstWhereOrNull((element) =>
              (isCreateOrder
                  ? element.isEnableCreateOrderInvoiceAutoPrint
                  : element.isEnableCheckoutOrderInvoiceAutoPrint));
          // await appDialogBox(
          //   Get.context!,
          //   dialogTitle: 'Available Printers',
          //   contentPage: AllPrintersListWidget(
          //     onTileTap: (selPrinter) {
          //       invoicePrinterInfo = selPrinter;
          //       Get.back();
          //     },
          //   ),
          // );
        }

        // if (
        //     // agr Auto Printer ke request receive hui hy or current iteration pr item k against printer ke auto printing b enabled hy to
        //     (isAutoPrintingOnly && isEnabledInvoice)
        //         // OR Condition
        //         ||
        //         // agr Non Auto Printer ke request receive hui hy or current iteration pr item k against printer ke auto printing disabled hy to
        //         (printOnlyNonAuto && !isEnabledInvoice)) {
        //   invoicePrinterInfo = AppStorage.getPrinterData()
        //       ?.firstWhereOrNull((element) => element.ipAddress == '10.10.10.142');
        //   await printInvoiceOfCreatedOrder();
        // }
        return null;
      } catch (e) {
        logger.e(
            'printCreatedOrderInvoice -> AllPrinterController -> Error => $e');
        return null;
      }
    }

    // Invoice Printer Information (Extract from storage and etc.)
    AllPrintersModel? invoicePrinterInfo =
        await extractInvoicePrinterAndPrintOrder();
    debugPrint('${invoicePrinterInfo?.name}');

    if (invoicePrinterInfo == null) return;

    //
    try {
      // if (Platform.isAndroid) {
      /// Android Platform Printing
      await selectDevice(setNetworkPrinterIpAddress(
        deviceName: '${invoicePrinterInfo.name}',
        address: '${invoicePrinterInfo.ipAddress}',
        port: invoicePrinterInfo.port,
      ));

      /// POS Utils Printing Approach ()
      CapabilityProfile _profile = await CapabilityProfile.load();
      List<int> bytes = [];
      const PaperSize paper = PaperSize.mm80;
      final generator = Generator(paper, _profile);

      bytes = await posInvoiceAndKotPrintLayout(
        generator,
        selectedSaleOrderData: orderDataForPrinting!,
        isInvoice: true,
        isKOT: false,
      );

      await _printEscPos(bytes, generator);

      /// PDF Approach (is main pdf generate kr k us ko image main convert kr b
      /// try kia hy or pdf ko preview krwa kr widget/screen ka screenshot ly kr
      /// be try kia tha)
      // await printScreenShotAsPage(
      //   Get.context!,
      //   printingPage: PosPrintLayout(
      //     // itemList: Get.find<ProductCartController>().itemCartList,
      //     selectedSaleOrderData:
      //         Get.find<ProductCartController>().orderDataForPrinting!,
      //     isInvoice: true,
      //     isKOT: false,
      //   ),
      // );
      // } else {
      //   /// Windows Platform Printing but Android is also added with view
      //   await directPrintInvoice(
      //     context: Get.context!,
      //     printerInfo: prt.Printer(
      //       location:
      //           '${invoicePrinterInfo.ipAddress}:${invoicePrinterInfo.port ?? 9100}',
      //       url: '${invoicePrinterInfo.name}',
      //     ),
      //     printLayout: (_) => InvoicePrintMethods().generatePdf(
      //       selectedSaleOrderData:
      //           Get.find<ProductCartController>().orderDataForPrinting,
      //     ),
      //   );
      // }
    } catch (err) {}
  }

  /// print ticket
  Future<void> _printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter == null) return;
    debugPrint('-----\nInside _printEscPos and printer is selected.\n-----');
    var bluetoothPrinter = selectedPrinter!;

    bytes += generator.feed(2);
    bytes += generator.cut();

    switch (bluetoothPrinter.typePrinter) {
      case PrinterType.usb:
        debugPrint(
            '-----\nInside _printEscPos. Selected printer type is USB.\n-----');
        await printerManager.connect(
          type: bluetoothPrinter.typePrinter,
          model: UsbPrinterInput(
            name: bluetoothPrinter.deviceName,
            productId: bluetoothPrinter.productId,
            vendorId: bluetoothPrinter.vendorId,
          ),
        );
        // pendingTask = null;
        break;
      case PrinterType.bluetooth:
        debugPrint(
            '-----\nInside _printEscPos. Selected printer type is Bluetooth.\n-----');
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false));
        // pendingTask = null;
        // if (Platform.isIOS || Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.network:
        debugPrint(
            '-----\nInside _printEscPos. Selected printer type is Network.\n-----');
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
        break;
      default:
    }
    // if (bluetoothPrinter.typePrinter == PrinterType.bluetooth &&
    //     Platform.isAndroid) {
    try {
      // print('------$_currentStatus');
      // if (_currentStatus == BTStatus.connected) {
      await printerManager
          .send(type: bluetoothPrinter.typePrinter, bytes: bytes)
          .then((value) async {
        if (value) {
          await PrinterManager.instance
              .disconnect(type: selectedPrinter!.typePrinter);
        }
      });

      // pendingTask = null;
      // }
    } catch (e) {
      debugPrint('-----\nError at Last of _printEscPos: $e.\n-----');
    }
    // } else {
    //   printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
    // }
  }
}

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});
}
