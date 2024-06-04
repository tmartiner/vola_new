import 'package:auth_client/auth_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState());

  void emailChanged(String value) {
    try {
      Email email = Email((email) => email..value = value);
      emit(
        state.copyWith(
          email: email,
          emailStatus: EmailStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          emailStatus: EmailStatus.invalid,
          emailErrorMessage: err.message,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          emailStatus: EmailStatus.invalid,
          emailErrorMessage: err.toString(),
        ),
      );
    }
  }

  void passwordChanged(String value) {
    try {
      Password password = Password((password) => password..value = value);
      emit(
        state.copyWith(
          password: password,
          passwordStatus: PasswordStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          passwordStatus: PasswordStatus.invalid,
          passwordErrorMessage: err.message,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          passwordStatus: PasswordStatus.invalid,
          passwordErrorMessage: err.toString(),
        ),
      );
    }
  }

  Future<void> login() async {
    if (!(state.emailStatus == EmailStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          formErrorMessage: 'Invalid email or password.',
        ),
      );
      // resetLogin();
      return;
    }
    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));

    try {
      await _authRepository.login(
        email: state.email!.value,
        password: state.password!.value,
      );
    } on LoginWithEmailAndPasswordFailure catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.submissionFailure,
          formErrorMessage: err.message,
        ),
      );
      // resetLogin();
    } catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.submissionFailure,
          formErrorMessage: err.toString(),
        ),
      );
      // resetLogin();
    }
  }

  // void resetLogin() {
  //   emit(const LoginState());
  // }
}
