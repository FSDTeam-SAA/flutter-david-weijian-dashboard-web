import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/add_test_centre_form.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/route_details.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/test_centre_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'package:david_weijian_dashboard/presentation/widgets/loading_widget.dart';


class MobileLayout extends StatelessWidget {
  final ContentController controller;
  
  const MobileLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => controller.isLoading.value ? const LoadingWidget() : const SizedBox()),
        Obx(() {
          if (controller.showAddTestCentreButton.value) {
            return AddTestCentreForm(controller: controller);
          } else if (controller.showRouteDetails.value) {
            return RouteDetailsWidget(controller: controller, testCentreId: controller.testCentreId.value,);
          }
          return TestCentreList(controller: controller);
        }),
      ],
    );
  }
}