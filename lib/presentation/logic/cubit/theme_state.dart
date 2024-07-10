part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState(this.themeMode);
  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(ThemeMode.system);
}

final class ThemeModeUpdated extends ThemeState {
  const ThemeModeUpdated(super.themeMode);
}
