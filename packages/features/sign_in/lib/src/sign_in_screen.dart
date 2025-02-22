import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.userRepository,
    this.onSignUpTap,
    this.onForgotMyPasswordTap,
    required this.onSignInSuccess,
  });

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(userRepository: userRepository),
      child: SignInView(
        onSignInSuccess: onSignInSuccess,
        onSignUpTap: onSignUpTap,
        onForgotMyPasswordTap: onForgotMyPasswordTap,
      ),
    );
  }
}

@visibleForTesting
class SignInView extends StatelessWidget {
  const SignInView({
    super.key,
    this.onSignUpTap,
    this.onForgotMyPasswordTap,
    required this.onSignInSuccess,
  });

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text('Sign In'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.mediumLarge,
            ),
            child: const Placeholder(),
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({
    required this.onSignInSuccess,
    this.onSignUpTap,
    this.onForgotMyPasswordTap,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignInCubit>();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        cubit.onEmailUnfocused();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen:
          (oldState, newState) =>
              oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          widget.onSignInSuccess();
          return;
        }
        final hasSubmissionError =
            state.submissionStatus == SubmissionStatus.genericError ||
            state.submissionStatus == SubmissionStatus.invalidCredentialsError;
        if (hasSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              state.submissionStatus == SubmissionStatus.invalidCredentialsError
                  ? SnackBar(content: Text("Invalid email and/or password."))
                  : const GenericErrorSnackbarAlert(),
            );
        }
      },
      builder: (context, state) {
        final emailError = state.email.isNotValid ? state.email.error : null;
        final passwordError =
            state.password.isNotValid ? state.password.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;
        final cubit = context.read<SignInCubit>();
        return Column(
          children: [
            TextField(
              focusNode: _emailFocusNode,
              onChanged: cubit.onEmailChanged,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.alternate_email),
                enabled: !isSubmissionInProgress,
                labelText: "Email",
                errorText:
                    emailError == null
                        ? null
                        : (emailError == EmailValidationError.empty
                            ? "Your email can't be empty."
                            : "This email is not valid."),
              ),
            ),
            const SizedBox(height: Spacing.large),
            TextField(
              focusNode: _passwordFocusNode,
              onChanged: cubit.onPasswordChanged,
              textInputAction: TextInputAction.next,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.password),
                enabled: !isSubmissionInProgress,
                labelText: "Password",
                errorText:
                    passwordError == null
                        ? null
                        : (passwordError == PasswordValidationError.empty
                            ? "Your password can't be empty."
                            : "Password must be at least five characters long."),
              ),
            ),
            TextButton(
              onPressed:
                  isSubmissionInProgress ? null : widget.onForgotMyPasswordTap,
              child: Text("Forgot my password"),
            ),
            const SizedBox(height: Spacing.small),
            isSubmissionInProgress
                ? ExpandedElevatedButton.inProgress(label: "Sign In")
                : ExpandedElevatedButton(
                  label: "Sign In",
                  onTap: cubit.onSubmit,
                  icon: const Icon(Icons.login),
                ),
            const SizedBox(height: Spacing.xxLarge),
            Text("Don't have an account?"),
            TextButton(
              onPressed: isSubmissionInProgress ? null : widget.onSignUpTap,
              child: Text("Sign Up"),
            ),
          ],
        );
      },
    );
  }
}
