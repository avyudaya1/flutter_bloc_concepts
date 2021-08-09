import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            appNotifications: false,
            emailNotifications: false,
          ),
        );

  void toggleAppNotifications(bool newValue) {
    //! you should never mutate existing states
    // state.appnotifications = newValue;

    ///! Dart knows this state is the same as previous emitted one so the new state is not emitted and ui wont change
    // emit(state);
    emit(state.copyWith(appNotifications: newValue));
  }

  void toggleEmailNotifications(bool newValue) =>
      emit(state.copyWith(emailNotifications: newValue));
}
