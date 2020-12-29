import 'dart:async';

import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  /// Initialize Connectivity Package
  final Connectivity connectivity;

  /// Create a new connectivity stream subscription
  StreamSubscription connectivityStreamSubscription;

  ConnectivityCubit({@required this.connectivity})
      : super(ConnectivityLoading()) {
    /// Monitor Current User's Network
    monitorInternetConnection();
  }

  /// Subscribe to the Connectivity onChange Network
  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      /// If User is Connected to Wifi, Emit a New Internet Connected State to Connection Type = Wifi
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      }

      /// If User is Connected to Mobile Data, Emit a New Internet Connected State to Connection Type = Mobile
      else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      }

      /// Otherwise, user is not connection to any network
      else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  /// Emit a new Internet Connection State
  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  /// Emit a new Internet Disconnected State
  void emitInternetDisconnected() => emit(InternetDisconnected());

  /// Close the Stream to Prevent Memory Leaks
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
