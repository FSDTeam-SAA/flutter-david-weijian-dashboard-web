import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/desktop_layout.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/mobile_layout.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';


class NavContentScreen extends StatelessWidget {
  final ContentController _controller = Get.put(ContentController());

  NavContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileLayout(controller: _controller),
        desktopBody: DesktopLayout(controller: _controller),
      ),
    );
  }
}