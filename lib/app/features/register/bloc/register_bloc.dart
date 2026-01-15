import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/services/auth_service_interface.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.authService) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthServiceInterface authService;

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterLoading());
      await authService.signUp(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
