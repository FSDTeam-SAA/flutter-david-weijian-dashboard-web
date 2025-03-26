import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/add_test_centre_form.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/route_details.dart';
import 'package:david_weijian_dashboard/presentation/screens/nav_items/nav_content/test_centre_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'package:david_weijian_dashboard/presentation/widgets/loading_widget.dart';

class DesktopLayout extends StatelessWidget {
  final ContentController controller;

  const DesktopLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: controller.showAddTestCentreButton.value ? 0 : 1,
          onDestinationSelected: (index) {
            controller.showAddTestCentreButton.value = index == 0;
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.add),
              label: Text('Add Test Centre'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.list),
              label: Text('View Test Centres'),
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Obx(
                () =>
                    controller.isLoading.value
                        ? const LoadingWidget()
                        : const SizedBox(),
              ),
              Obx(() {
                if (controller.showAddTestCentreButton.value) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: AddTestCentreForm(controller: controller),
                  );
                } else if (controller.showRouteDetails.value) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: RouteDetailsWidget(
                      controller: controller,
                      testCentreId: controller.testCentreId.value,
                    ),
                  );
                }
                return TestCentreList(controller: controller);
              }),
            ],
          ),
        ),
      ],
    );
  }
}
