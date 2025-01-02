import 'package:bloc/bloc.dart';
import 'package:rest_api_app/data/bloc/auth_bloc/auth_event.dart';
import 'package:rest_api_app/data/bloc/auth_bloc/auth_state.dart';
import 'package:rest_api_app/data/repository/authentication_repository.dart';
import 'package:rest_api_app/gitit/gitit.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();

  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var login = await _authRepository.login(event.username, event.password);

      emit(AuthRequestSuccessState(login));
    });
    on<AuthRegisterRequest>((event, emit) async {
      emit(AuthLoadingState());
      var register = await _authRepository.register(
          event.email, event.password, event.passwordConfirm, event.name);

      emit(AuthRequestSuccessState(register));
    });
  }
}
