part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotifications;
  final bool emailNotifications;

  SettingsState({
    @required this.appNotifications,
    @required this.emailNotifications,
  });

  //*NEW INSTANCE OF SETTINGS STATE WITH NEW VALUES
  SettingsState copyWith({
    bool appNotifications,
    bool emailNotifications,
  }) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }

  //* Always add props that we want to equate of. adding emailNotifications only will not change the state whatever the email toggles to
  @override
  List<Object> get props => [
        emailNotifications,
        appNotifications,
      ];

  @override
  String toString() =>
      'SettingsState(appNotifications: $appNotifications, emailNotifications: $emailNotifications)';
}
