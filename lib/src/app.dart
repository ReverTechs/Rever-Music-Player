import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rever/src/bloc/theme/theme_bloc.dart';
import 'package:rever/src/core/router/app_router.dart';
import 'package:rever/src/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rever Music',
          theme: AppThemeData.getTheme(),
          onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        );
      },
    );
  }
}
