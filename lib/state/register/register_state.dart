part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final Email? email;
  final Password? password;
  final EmailStatus emailStatus;
  final PasswordStatus passwordStatus;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final FormStatus formStatus;

  const RegisterState({
    this.email,
    this.password,
    this.emailStatus = EmailStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.formStatus = FormStatus.initial,
  });

  RegisterState copyWith({
    Email? email,
    Password? password,
    EmailStatus? emailStatus,
    PasswordStatus? passwordStatus,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    FormStatus? formStatus,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailStatus,
        passwordStatus,
        emailErrorMessage,
        passwordErrorMessage,
        formStatus,
      ];
}
