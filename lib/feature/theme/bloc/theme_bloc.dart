import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDark = false;
  ThemeBloc() : super(ThemeInitial(lightTheme)) {
    on<ThemeEvent>((event, emit) {
      if (event is ToggleTheme) {
        final state = this.state;
        if (state.theme == lightTheme) {
          isDark = true;
          emit(ThemeInitial(darkTheme));
        } else {
          isDark = false;
          emit(ThemeInitial(lightTheme));
        }
      }
    });
  }
}
