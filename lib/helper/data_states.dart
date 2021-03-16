class DataState {
  DataState._();

  factory DataState.success(var data) = SuccessState;

  factory DataState.error() = ErrorState;

  factory DataState.noConnection() = NoConnectionState;
}

class SuccessState extends DataState {
  SuccessState(this.data) : super._();
  var data;
}

class ErrorState extends DataState {
  ErrorState() : super._();
}

class NoConnectionState extends DataState {
  NoConnectionState() : super._();
}
