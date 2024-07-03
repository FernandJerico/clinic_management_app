import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:clinic_management_app/features/auth/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasources authRemoteDatasources;
  LoginBloc(this.authRemoteDatasources) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDatasources.login(
          event.email, event.password, event.fcmToken);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
