part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

/// Initial State of Connectivity
class ConnectivityLoading extends ConnectivityState {}

/// State if user is connected to a network
class InternetConnected extends ConnectivityState {
  final ConnectionType connectionType;

  InternetConnected({@required this.connectionType});
}

/// State if user isn't connected to any network
class InternetDisconnected extends ConnectivityState {}
