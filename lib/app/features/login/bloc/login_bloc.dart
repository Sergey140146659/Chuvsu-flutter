import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/services/auth_service_interface.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthServiceInterface authService;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      await authService.logIn(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
