import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_menu/src/profile_menu_bloc.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'dark_mode_preference_picker.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({
    super.key,
    required this.userRepository,
    required this.quoteRepository,
    this.onSignInTap,
    this.onSignUpTap,
    this.onUpdateProfileTap,
  });

  final VoidCallback? onSignInTap;
  final VoidCallback? onUpdateProfileTap;
  final VoidCallback? onSignUpTap;
  final UserRepository userRepository;
  final QuoteRepository quoteRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ProfileMenuBloc(
            userRepository: userRepository,
            quoteRepository: quoteRepository,
          ),
      child: ProfileMenuView(
        onSignInTap: onSignInTap,
        onUpdateProfileTap: onUpdateProfileTap,
        onSignUpTap: onSignUpTap,
      ),
    );
  }
}

@visibleForTesting
class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({
    super.key,
    this.onSignInTap,
    this.onSignUpTap,
    this.onUpdateProfileTap,
  });

  final VoidCallback? onSignInTap;
  final VoidCallback? onUpdateProfileTap;
  final VoidCallback? onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return StyledStatusBar.dark(
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
            builder: (context, state) {
              if (state is ProfileMenuLoaded) {
                final username = state.username;
                return Column(
                  children: [
                    if (!state.isAuthenticated) ...[
                      _SignInButton(onSignInTap: onSignInTap),
                      const SizedBox(height: Spacing.xLarge),
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: onSignUpTap,
                        child: Text("Sign Up"),
                      ),
                      const SizedBox(height: Spacing.large),
                    ],
                    if (username != null) ...[
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(Spacing.small),
                            child: ShrinkableText(
                              data: "Hi, $username!",
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      ChevronListTile(
                        label: "Update Profile",
                        onTap: onUpdateProfileTap,
                      ),
                      const Divider(),
                      const SizedBox(height: Spacing.mediumLarge),
                    ],
                    DarkModePreferencePicker(
                      currentValue: state.darkModePreference,
                    ),
                    if (state.isAuthenticated) ...[
                      const Spacer(),
                      _SignOutButton(
                        isSignOutInProgress: state.isSignOutInProgress,
                      ),
                    ],
                  ],
                );
              } else {
                return const CenteredCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: theme.screenMarging,
        right: theme.screenMarging,
        top: Spacing.xxLarge,
      ),
      child: ExpandedElevatedButton(
        label: "Sign In",
        onTap: onSignInTap,
        icon: const Icon(Icons.login),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({super.key, required this.isSignOutInProgress});

  final bool isSignOutInProgress;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: theme.screenMarging,
        right: theme.screenMarging,
        bottom: Spacing.xLarge,
      ),
      child:
          isSignOutInProgress
              ? ExpandedElevatedButton.inProgress(label: "Sign Out")
              : ExpandedElevatedButton(
                label: "Sign Out",
                onTap: () {
                  final bloc = context.read<ProfileMenuBloc>();
                  bloc.add(const ProfileMenuSignedOut());
                },
                icon: const Icon(Icons.logout),
              ),
    );
  }
}
