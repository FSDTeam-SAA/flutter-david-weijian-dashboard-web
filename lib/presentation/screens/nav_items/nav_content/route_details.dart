import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'route_card.dart';

class RouteDetailsWidget extends StatelessWidget {
  final ContentController controller;
  final String testCentreId;

  const RouteDetailsWidget({
    super.key,
    required this.controller,
    required this.testCentreId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Center(
            child: ElevatedButton(
              onPressed: () => controller.showRouteDetails.value = false,
              child: const Text('Back to Test Centres'),
            ),
          ),
          const SizedBox(height: 20),

          // Main content with safe access checks
          _buildSafeContent(),
        ],
      ),
    );
  }

  Widget _buildSafeContent() {
    // Find the test centre from the list
    final testCentre = controller.testCentres.firstWhereOrNull(
      (centre) => centre.id == testCentreId,
    );

    if (testCentre == null) {
      return const _ErrorWidget(message: 'Test centre not found');
    }

    if (controller.routeResponse.value == null) {
      return const _ErrorWidget(message: 'No route data loaded');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Test Centre Details
        _buildSectionTitle('Test Centre Details'),
        _buildDetailRow('Name', testCentre.name),
        _buildDetailRow('Address', testCentre.address),
        _buildDetailRow('Post Code', testCentre.postCode),
        _buildDetailRow('Pass Rate', '${testCentre.passRate}%'),
        _buildDetailRow('Routes', '${testCentre.routes}'),
        const SizedBox(height: 20),

        // Action Buttons for editing and deleting test centre
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => controller.setTestCentreForEditing(testCentre),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed:
                  () => _showDeleteTestCentreConfirmationDialog(testCentre.id),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Add New Route Button
        ElevatedButton(
          onPressed: () {
            // Reset the form first
            controller.resetRouteForm();

            // Set route mode
            controller.routeId.value = ''; // Empty for new route
            controller.testCentreId.value = testCentre.id;
            controller.testCentreName.value = testCentre.name;

            // Show the route form
            controller.showAddTestCentre.value = true;
            controller.showAddTestCentreButton.value = true;
            controller.addNewRoute.value = true;
          },
          child: const Text('Add New Route'),
        ),
        const SizedBox(height: 20),

        // Route Information
        _buildSectionTitle('Route Information'),
        if (controller.routeResponse.value!.data.isEmpty)
          const Text('No routes available for this test centre')
        else
          ...controller.routeResponse.value!.data.map(
            (route) => RouteCard(route: route, controller: controller),
          ),
      ],
    );
  }

  void _handleEditTestCentre(String testCentreId) {
    try {
      final testCentre = controller.testCentres.firstWhere(
        (centre) => centre.id == testCentreId,
      );
      controller.setTestCentreForEditing(testCentre);
      controller.showAddTestCentreButton.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Test centre not found');
    }
  }

  // Reusable widgets
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _showDeleteTestCentreConfirmationDialog(String routeId) {
    Get.defaultDialog(
      title: 'Delete Route',
      middleText: 'Are you sure you want to delete this route?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        try {
          await controller.deleteTestCentre(routeId);
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete route');
        }
      },
      onCancel: () => Get.back(),
    );
  }
}

// Separate error widget for better organization
class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }
}
