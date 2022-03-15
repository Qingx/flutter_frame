import 'package:flutter/material.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeInitEvent extends ThemeEvent {
  const ThemeInitEvent();
}

class ThemeLocalChangeEvent extends ThemeEvent {
  const ThemeLocalChangeEvent();
}

class ThemeFollowSystemChangeEvent extends ThemeEvent {
  final Brightness currentSystemState;

  const ThemeFollowSystemChangeEvent(this.currentSystemState);
}
