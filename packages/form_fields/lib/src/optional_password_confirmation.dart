import 'package:equatable/equatable.dart';
import 'package:form_fields/src/optional_password.dart';
import 'package:formz/formz.dart';

enum OptionalPasswordConfirmationValidationError { empty, invalid }

class OptionalPasswordConfirmation
    extends FormzInput<String, OptionalPasswordConfirmationValidationError>
    with EquatableMixin {
  final OptionalPassword password;

  const OptionalPasswordConfirmation.unvalidated([String value = ''])
    : password = const OptionalPassword.unvalidated(),
      super.pure(value);

  const OptionalPasswordConfirmation.validated(
    String value, {
    required this.password,
  }) : super.dirty(value);

  @override
  List<Object?> get props => [value, isPure, password];

  @override
  OptionalPasswordConfirmationValidationError? validator(String value) {
    return value.isEmpty
        ? OptionalPasswordConfirmationValidationError.empty
        : (value == password.value
            ? null
            : OptionalPasswordConfirmationValidationError.invalid);
  }
}
