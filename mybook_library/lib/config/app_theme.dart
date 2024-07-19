import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple[100]!,
    colorScheme: ColorScheme.light(
      secondary: Colors.purple[200]!,
    ),
    scaffoldBackgroundColor: Colors.purple[50]!,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[200]!,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.purple[100]!,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple[200]!;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple[100]!;
        }
        return Colors.grey;
      }),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[850]!,
    colorScheme: ColorScheme.dark(
      secondary: Colors.purple[200]!,
    ),
    scaffoldBackgroundColor: Colors.grey[900]!,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850]!,
      iconTheme: IconThemeData(color: Colors.purple[200]!),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[850]!,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple[200]!;
        }
        return Colors.grey[300]!;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple[100]!;
        }
        return Colors.grey;
      }),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.purple[200]!),
    ),
  );
}
