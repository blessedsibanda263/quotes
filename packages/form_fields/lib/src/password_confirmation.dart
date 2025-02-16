import 'package:equatable/equatable.dart';
import 'package:form_fields/src/password.dart';
import 'package:formz/formz.dart';

enum PasswordConfirmationValidationError { empty, invalid }

class PasswordConfirmation
    extends FormzInput<String, PasswordConfirmationValidationError>
    with EquatableMixin {
  final Password password;

  const PasswordConfirmation.unvalidated([String value = ''])
    : password = const Password.unvalidated(),
      super.pure(value);

  const PasswordConfirmation.validated(String value, {required this.password})
    : super.dirty(value);

  @override
  List<Object?> get props => [value, isPure, password];

  @override
  PasswordConfirmationValidationError? validator(String value) {
    return value.isEmpty
        ? PasswordConfirmationValidationError.empty
        : (value == password.value
            ? null
            : PasswordConfirmationValidationError.invalid);
  }
}
