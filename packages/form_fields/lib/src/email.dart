import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid, alreadyRegistered }

class Email extends FormzInput<String, EmailValidationError>
    with EquatableMixin {
  final bool isAlreadyRegistered;

  const Email.validated(String value, {this.isAlreadyRegistered = false})
    : super.dirty(value);

  const Email.unvalidated([String value = ''])
    : isAlreadyRegistered = false,
      super.pure(value);

  static final _emailRegex = RegExp(
    '^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@((([0-1]?'
    '[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
    '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
    ')|([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$',
  );

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.empty
        : (isAlreadyRegistered
            ? EmailValidationError.alreadyRegistered
            : (_emailRegex.hasMatch(value)
                ? null
                : EmailValidationError.invalid));
  }

  @override
  List<Object?> get props => [value, isPure, isAlreadyRegistered];
}
