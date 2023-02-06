import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  ///Fetch the Connection Status...
  ConnectivityService() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      connectionStatus = _networkStatus(event);
    });
  }
  ConnectionStatus connectionStatus = ConnectionStatus.offline;

  ConnectionStatus _networkStatus(InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        return ConnectionStatus.online;

      case InternetConnectionStatus.disconnected:
        return ConnectionStatus.offline;
    }
  }
}

enum ConnectionStatus {
  online,
  offline,
}
