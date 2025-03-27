import 'package:flutter/material.dart';
import 'package:david_weijian_dashboard/model/route_model.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'stop_card.dart';
import 'package:get/get.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;
  final ContentController controller;

  const RouteCard({super.key, required this.route, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Route Name: ${route.routeName}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('From', route.from),
            _buildDetailRow('To', route.to),
            _buildDetailRow('Expected Time', '${route.expectedTime} minutes'),
            _buildDetailRow('Share URL', route.shareUrl),
            const SizedBox(height: 10),
            _buildDetailRow(
              'Start Coordinates',
              'Lat: ${route.startCoordinator['lat'] ?? 0.0}, Lng: ${route.startCoordinator['lng'] ?? 0.0}',
            ),
            _buildDetailRow(
              'End Coordinates',
              'Lat: ${route.endCoordinator['lat'] ?? 0.0}, Lng: ${route.endCoordinator['lng'] ?? 0.0}',
            ),
            const SizedBox(height: 10),
            const Text(
              'Stops',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...route.listOfStops.map((stop) => StopCard(stop: stop)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    controller.showAddTestCentreButton.value = true;
                    controller.setSelectedRouteForEditing(route);
                    // controller.showAddTestCentre.value = true;
                    // controller.showRouteDetails.value = false;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteRouteConfirmationDialog(route.id);
                  },
                ),
              ],
            ),
          ],
        ),
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

  void _showDeleteRouteConfirmationDialog(String routeId) {
    Get.defaultDialog(
      title: 'Delete Route',
      middleText: 'Are you sure you want to delete this route?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        await controller.deleteRoute(routeId);
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
