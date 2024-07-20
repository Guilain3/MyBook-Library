import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utils/constants.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';
import 'state/app_state.dart';
import 'state/book_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSt()),
        ChangeNotifierProvider(create: (_) => BkSt()),
      ],
      child: Consumer<AppSt>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: Constants.appName,
            theme: appState.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            routes: AppRoutes.routes,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
