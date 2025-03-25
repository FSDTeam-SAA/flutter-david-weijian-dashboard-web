
import 'package:david_weijian_dashboard/core/binders/nav_binder.dart';
import 'package:david_weijian_dashboard/core/theme/theme_data.dart';
import 'package:david_weijian_dashboard/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
    );
  }
}
