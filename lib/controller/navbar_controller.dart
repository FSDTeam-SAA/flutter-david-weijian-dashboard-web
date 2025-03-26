// lib/navbar/controllers/nav_controller.dart
import 'package:david_weijian_dashboard/presentation/screens/auth/dashboard.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/nav_content_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_customer_support_feed_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_feature_access_lim_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_marketing_promotions_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_package_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_report_analytics.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_securities_compliance_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_subcription_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  // var currentScreen = Rx<Widget>(const Center(child: Text("Body"))); // Declare as Rx<Widget>
  var currentScreen = Rx<Widget>(AdminDashboard());

  void changeScreen(String item) {
    switch (item) {
      case 'User':
        currentScreen.value = NavUserScreen();
        break;
      case 'Subscription':
        currentScreen.value = NavSubcriptionScreen();
        break;
      case 'Package':
        currentScreen.value = NavPackageScreen();
        break;
      case 'Content':
        currentScreen.value = NavContentScreen();
        break;
      case 'Feature Access Limitation':
        currentScreen.value = NavFeatureAccessLimScreen();
        break;
      case 'Report & Analytics':
        currentScreen.value = NavReportAnalytics();
        break;
      case 'Marketing & Promotions':
        currentScreen.value = NavMarketingPromotionsScreen();
        break;
      case 'Customer Support Feedback':
        currentScreen.value = NavCustomerSupportFeedScreen();
        break;
      case 'Securities Compliance':
        currentScreen.value = NavSecuritiesComplianceScreen();
        break;
      default:
        currentScreen.value = const Center(child: Text("Body"));
    }
  }
}
