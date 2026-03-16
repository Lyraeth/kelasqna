import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Service responsible for monitoring network connectivity and internet access.
///
/// This service provides a unified interface to:
/// 1. Monitor changes in the network interface (Wi-Fi, Mobile Data, etc.) using [Connectivity].
/// 2. Verify actual internet reachability (real-world connection) using [InternetConnectionChecker].
///
/// It is typically used to prevent API calls when the device is offline or to
/// notify the user about their connection status.
class ConnectivityService {
  final Connectivity _connectivity;
  final InternetConnectionChecker _internetConnectionChecker;

  /// Creates a [ConnectivityService] with the required dependencies.
  ///
  /// Requires an instance of [Connectivity] and [InternetConnectionChecker]
  /// usually provided via Dependency Injection (e.g., GetIt).
  ConnectivityService({
    required Connectivity connectivity,
    required InternetConnectionChecker internetConnectionChecker,
  }) : _connectivity = connectivity,
       _internetConnectionChecker = internetConnectionChecker;

  /// A stream that emits a list of [ConnectivityResult] whenever the device's
  /// network interface changes.
  ///
  /// Note: This only indicates whether the device is connected to a network interface
  /// (like Wi-Fi or Cellular), but doesn't guarantee actual internet access.
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  /// Returns `true` if the device has actual internet access.
  ///
  /// This method goes beyond checking the network interface; it attempts to
  /// verify if data can actually be sent and received by pinging reliable hosts.
  Future<bool> get hasInternetAccess =>
      _internetConnectionChecker.hasConnection;
}
