// import 'package:david_weijian_dashboard/model/stops_model.dart';
// import 'package:david_weijian_dashboard/model/test_centre_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:david_weijian_dashboard/controller/content_controller.dart';

// class RouteDetailsScreen extends StatelessWidget {
//   final ContentController _controller = Get.find();

//   RouteDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Back button to return to the test centre list
//           ElevatedButton(
//             onPressed: () {
//               _controller.showRouteDetails.value = false;
//             },
//             child: const Text('Back to Test Centres'),
//           ),
//           const SizedBox(height: 20),

//           // Display route details
//           if (_controller.routeResponse.value != null)
//             _buildRouteDetails(_controller.routeResponse.value!),
//         ],
//       ),
//     );
//   }

//   Widget _buildRouteDetails(TestCentre routeResponse) {
//     final route = routeResponse.data.first; // Assuming only one route is returned

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Test Centre Details
//         _buildSectionTitle('Test Centre Details'),
//         _buildDetailRow('Name', route.testCentreName),
//         _buildDetailRow('Address', route.address),
//         _buildDetailRow('Pass Rate', '${route.passRate}%'),
//         const SizedBox(height: 20),

//         // Route Details
//         _buildSectionTitle('Route Details'),
//         _buildDetailRow('Route Name', route.routeName),
//         _buildDetailRow('From', route.from),
//         _buildDetailRow('To', route.to),
//         _buildDetailRow('Expected Time', '${route.expectedTime} minutes'),
//         _buildDetailRow('Share URL', route.shareUrl),
//         const SizedBox(height: 20),

//         // Start and End Coordinates
//         _buildSectionTitle('Coordinates'),
//         _buildDetailRow(
//           'Start',
//           'Lat: ${route.startCoordinator['lat']}, Lng: ${route.startCoordinator['lng']}',
//         ),
//         _buildDetailRow(
//           'End',
//           'Lat: ${route.endCoordinator['lat']}, Lng: ${route.endCoordinator['lng']}',
//         ),
//         const SizedBox(height: 20),

//         // List of Stops
//         _buildSectionTitle('Stops'),
//         ...route.listOfStops.map((stop) => _buildStopCard(stop)).toList(),
//       ],
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.blue,
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStopCard(Stop stop) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         title: Text('Stop ID: ${stop.id}'),
//         subtitle: Text('Lat: ${stop.lat}, Lng: ${stop.lng}'),
//       ),
//     );
//   }

// }
