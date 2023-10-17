import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:may/config/data_config.dart';
import 'package:may/theme/theme_event.dart';
import 'package:may/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          DataConfig.getIns().themeMode
              ? ThemeState.System
              : DataConfig.getIns().themeType == 0
                  ? ThemeState.Light
                  : ThemeState.Dark,
        );

  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeInitEvent) {
      yield _doInitState(state);
    } else if (event is ThemeLocalChangeEvent) {
      yield _doLocalThemeChangeState(state);
    } else if (event is ThemeFollowSystemChangeEvent) {
      yield _doFollowSystemChangeState(event, state);
    }
  }

  ThemeState _doInitState(ThemeState state) {
    state = DataConfig.getIns().themeMode
        ? ThemeState.System
        : DataConfig.getIns().themeType == 0
            ? ThemeState.Light
            : ThemeState.Dark;
    return state;
  }

  ThemeState _doLocalThemeChangeState(ThemeState state) {
    var isCurrentFollowSystem = DataConfig.getIns().themeMode;
    if (!isCurrentFollowSystem) {
      var lastThemeState = DataConfig.getIns().themeType == 0
          ? ThemeState.Light
          : ThemeState.Dark;

      if (lastThemeState == ThemeState.Light) {
        state = ThemeState.Dark;
        DataConfig.getIns().themeType = 1;
      } else {
        state = ThemeState.Light;
        DataConfig.getIns().themeType = 0;
      }
    }

    return state;
  }

  ThemeState _doFollowSystemChangeState(
      ThemeFollowSystemChangeEvent event, ThemeState state) {
    var isCurrentFollowSystem = DataConfig.getIns().themeMode;
    DataConfig.getIns().themeMode = !isCurrentFollowSystem;

    if (!isCurrentFollowSystem) {
      state = ThemeState.System;
      DataConfig.getIns().themeType =
          event.currentSystemState == Brightness.light ? 0 : 1;
    } else {
      state = DataConfig.getIns().themeType == 0
          ? ThemeState.Light
          : ThemeState.Dark;
    }
    return state;
  }
}
