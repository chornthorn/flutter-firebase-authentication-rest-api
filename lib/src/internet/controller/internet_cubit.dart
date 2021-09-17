import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit(this.connectivity) : super(InternetLoading()) {
    _subscription = connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  void _onConnectivityChanged(result) {
    if (result == ConnectivityResult.wifi) {
      connected(ConnectionType.wifi);
    } else if (result == ConnectivityResult.mobile) {
      connected(ConnectionType.mobile);
    } else if (result == ConnectivityResult.none) {
      disconnected();
    }
  }

  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;

  void connected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void disconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
