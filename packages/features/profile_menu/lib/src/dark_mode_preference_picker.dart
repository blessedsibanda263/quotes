part of 'profile_menu_screen.dart';

class DarkModePreferencePicker extends StatelessWidget {
  const DarkModePreferencePicker({super.key, required this.currentValue});

  final DarkModePreference currentValue;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileMenuBloc>();
    return Column(
      children: [
        ListTile(
          title: Text(
            "Dark Mode Preferences",
            style: const TextStyle(
              fontSize: FontSize.mediumLarge,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ...ListTile.divideTiles(
          tiles: [
            RadioListTile(
              title: Text("Always Dark"),
              value: DarkModePreference.alwaysDark,
              groupValue: currentValue,
              onChanged: (newOption) {
                bloc.add(
                  const ProfileMenuDarkPreferenceChanged(
                    DarkModePreference.alwaysDark,
                  ),
                );
              },
            ),
            RadioListTile(
              title: Text("Always Light"),
              value: DarkModePreference.alwaysLight,
              groupValue: currentValue,
              onChanged: (newOption) {
                bloc.add(
                  const ProfileMenuDarkPreferenceChanged(
                    DarkModePreference.alwaysLight,
                  ),
                );
              },
            ),
            RadioListTile(
              title: Text("Use System Settings"),
              value: DarkModePreference.useSystemSettings,
              groupValue: currentValue,
              onChanged: (newOption) {
                bloc.add(
                  const ProfileMenuDarkPreferenceChanged(
                    DarkModePreference.useSystemSettings,
                  ),
                );
              },
            ),
          ],
          context: context,
        ),
      ],
    );
  }
}
