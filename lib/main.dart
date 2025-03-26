import 'package:david_weijian_dashboard/configure_web.dart';
import 'package:david_weijian_dashboard/core/binders/nav_binder.dart';
import 'package:david_weijian_dashboard/core/theme/theme_data.dart';
import 'package:david_weijian_dashboard/presentation/screens/auth/login_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/main_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('App starting...'); // Add this

  try {
    configureApp();
    print('App configured'); // Add this
    runApp(const MyApp());
  } catch (e) {
    print('Error in main: $e'); // Add this
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driving Test',
      theme: AppThemes.appThemeData,
      initialBinding: Binding(),
      home: SplashScreen(),
      // Add this for web
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => MainScreen()),
      ],
    );
  }
}
