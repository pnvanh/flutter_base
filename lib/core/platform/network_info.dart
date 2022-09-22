import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplement implements NetworkInfo {
  final connectionChecker = InternetConnectionChecker();

  NetworkInfoImplement();

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
