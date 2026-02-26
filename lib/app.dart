import 'package:flutter/material.dart';
import 'package:flutter_application/routes/routes.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFF0F0F0),
            fontFamily: 'Avenir',
          ),
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}