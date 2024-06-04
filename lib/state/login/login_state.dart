part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email? email;
  final Password? password;
  final EmailStatus emailStatus;
  final PasswordStatus passwordStatus;
  final FormStatus formStatus;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? formErrorMessage;

  const LoginState({
    this.email,
    this.password,
    this.emailStatus = EmailStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.formStatus = FormStatus.initial,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.formErrorMessage,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    EmailStatus? emailStatus,
    PasswordStatus? passwordStatus,
    FormStatus? formStatus,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? formErrorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      formStatus: formStatus ?? this.formStatus,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      formErrorMessage: formErrorMessage ?? this.formErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailStatus,
        passwordStatus,
        formStatus,
        emailErrorMessage,
        passwordErrorMessage,
        formErrorMessage,
      ];
}
