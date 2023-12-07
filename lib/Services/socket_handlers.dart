import 'package:socket_io_client/socket_io_client.dart' as socket_io_cli;

import '/Config/app_config.dart';
import '/Config/utils.dart';
import 'storage_services.dart';

SocketService? socketService;

class SocketService {
  static int retryLimits = 2;
  static final socket_io_cli.Socket _socket = socket_io_cli.io(
    AppConfig.socketBaseUrl,
    socket_io_cli.OptionBuilder().setTransports(['websocket']).build(),
  );
  static int conEstTried = 0;

  bool isEstConnCalled = false;
  bool isConnEst = false;
  bool isUserEmitted = false;

  SocketService() {
    establishConnection();
  }

  void establishConnection() {
    if (!isEstConnCalled &&
        !isConnEst &&
        AppStorage.getLoggedUserData() != null) {
      _socket.connect();
      isEstConnCalled = true;
    }

    _socket.onConnect((_) {
      isConnEst = true;
      isEstConnCalled = false;
      logger.i('socket connection status => ${_socket.connected}');
      emitUser();
    });

    _socket.onConnectTimeout((data) {
      // logger.wtf('socket connection timeout => $data');
      // isEstConnCalled = false;
    });

    /// Order Event Socket
    _socket.on('private-channel:App\\Events\\OrderEvent', (_order) {
      logger.d('Order Socket Event => $_order');
    });

    // /// Table update Socket Event
    // _socket.on('table-channel:App\\Events\\TableCreateEvent', (_table) {
    //   logger.d('Table Socket Event => $_table');
    //   Get.find<TableSelectionController>().updateTableInfo(tableData: _table);
    // });

    _socket.onConnectError((_) {
      isConnEst = false;
      isEstConnCalled = false;
      isUserEmitted = false;
      // logger.w('connection error');
    });

    _socket.onError((_) {
      isConnEst = false;
      isEstConnCalled = false;
      isUserEmitted = false;
      // logger.e('on error');
    });

    _socket.onDisconnect((_) {
      isConnEst = false;
      isEstConnCalled = false;
      isUserEmitted = false;
      // logger.w('on disconnect');
    });
  }

  emitUser() async {
    if (AppStorage.getLoggedUserData() != null && !isUserEmitted) {
      for (int i = 0; i < retryLimits; i++) {
        if (_socket.connected) {
          _socket.emit('user_connected',
              '${AppStorage.getLoggedUserData()?.staffUser.id}');
          isUserEmitted = true;
          logger.i('emitted user successfully.');
          return;
        } else {
          SocketService.dispose();
          socketService = SocketService();
        }
      }
    }
  }

  static void dispose() {
    _socket.close();
    _socket.disconnect();
    _socket.destroy();
    _socket.dispose();
  }
}
