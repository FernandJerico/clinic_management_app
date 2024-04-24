part of 'qris_bloc.dart';

@freezed
class QrisState with _$QrisState {
  const factory QrisState.initial() = _Initial;
  const factory QrisState.loading() = _Loading;
  const factory QrisState.qrisResponse(QrisResponseModel qrisResponseModel) =
      _QrisResponse;
  const factory QrisState.qrisStatus(
      QrisStatusResponseModel qrisStatusResponseModel) = _QrisStatusCheck;
  const factory QrisState.error(String message) = _Error;
  const factory QrisState.success(String message) = _Success;
}
