import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text('Settings'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificaitonSnackBar = SnackBar(
            content: Text('App ' +
                state.appNotifications.toString().toUpperCase() +
                ', Email ' +
                state.emailNotifications.toString().toUpperCase()),
            duration: Duration(milliseconds: 700),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificaitonSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue);
                  },
                  title: Text('App Notificaitons'),
                ),
                SwitchListTile(
                  value: state.emailNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleEmailNotifications(newValue);
                  },
                  title: Text('Email Notifications'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
