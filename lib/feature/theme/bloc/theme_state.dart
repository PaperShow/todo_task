part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState(this.theme);

  final ThemeData theme;

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial(super.theme);
}
