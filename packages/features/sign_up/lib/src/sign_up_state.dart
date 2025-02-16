import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';

enum SubmissionStatus { idle, inProgress, success, error }

class SignUpState extends Equatable {
  final Email email;
  final Username username;
  final Password password;
  final PasswordConfirmation passwordConfirmation;
  final SubmissionStatus submissionStatus;

  const SignUpState({
    this.email = const Email.unvalidated(),
    this.username = const Username.unvalidated(),
    this.password = const Password.unvalidated(),
    this.passwordConfirmation = const PasswordConfirmation.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  SignUpState copyWith({
    Email? email,
    Username? username,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    SubmissionStatus? submissionStatus,
  }) {
    return SignUpState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    email,
    username,
    password,
    passwordConfirmation,
    submissionStatus,
  ];
}
