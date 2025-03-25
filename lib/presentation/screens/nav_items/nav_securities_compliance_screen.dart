import 'package:cached_network_image/cached_network_image.dart';
import 'package:david_weijian_dashboard/controller/bugreport_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavSecuritiesComplianceScreen extends StatelessWidget {
  const NavSecuritiesComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BugReportController controller = Get.put(BugReportController());

    return Scaffold(
      appBar: AppBar(title: Text('Bug Reports')),
      body: Obx(() {
        // Show a loading indicator while fetching data
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Show a message if there are no bug reports
        if (controller.bugReports.isEmpty) {
          return Center(child: Text("No bug reports available"));
        }

        // Display the bug report data in a list view
        return ListView.builder(
          itemCount: controller.bugReports.length,
          itemBuilder: (context, index) {
            final bugReport = controller.bugReports[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(bugReport.project),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Screen Name: ${bugReport.screenName}'),
                    Text('Message: ${bugReport.message}'),
                    Text('Created At: ${bugReport.createdAt}'),
                    // Todo : Press the image to show full screen
                    CachedNetworkImage(
                      imageUrl: bugReport.image,
                      placeholder:
                          (context, url) =>
                              CircularProgressIndicator(), // Placeholder
                      errorWidget:
                          (context, url, error) =>
                              Icon(Icons.error), // Error widget
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      }),
    );
  }
}
