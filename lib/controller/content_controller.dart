import 'package:david_weijian_dashboard/model/route_model.dart';
import 'package:david_weijian_dashboard/model/test_centre_model.dart';
import 'package:david_weijian_dashboard/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:math';

class ContentController extends GetxController {
  // Reactive variables for UI input
  var testCentreName = ''.obs;
  var passRate = '0'.obs;
  var routes = 0.obs;
  var testCentreAddress = ''.obs;
  var postCode = ''.obs;

  var testCentreId = ''.obs;
  var routeId = ''.obs;

  var routeName = ''.obs;
  var shareUrl = ''.obs;
  var address = ''.obs;
  var fileName = ''.obs;
  var from = ''.obs;
  var to = ''.obs;
  var expectedTime = 0.obs;
  var listOfStops = <Map<String, dynamic>>[].obs;
  var showAddTestCentre = true.obs;
  var selectedTestCentre = <String, dynamic>{}.obs;

  var routeResponse = Rx<RouteResponse?>(null);

  var isLoading = false.obs;

  // Button releted variables
  var showAddTestCentreButton = false.obs;

  // New variable to track if route details should be shown
  var showRouteDetails = false.obs;

  var isEditing = false.obs;

  var testCentres = <TestCentre>[].obs; // List of test centres

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchAllTestCentres();
    super.onInit();
  }

  // Fetch all test centres
  Future<void> fetchAllTestCentres() async {
    isLoading.value = true;
    try {
      final response = await _apiService.getAllTestCentres();
      if (response['status'] == true) {
        testCentres.value = List<TestCentre>.from(
          response['data'].map((centre) => TestCentre.fromJson(centre)),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch test centres: ${response['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllRoutes(String id) async {
    isLoading.value = true;
    try {
      final response = await _apiService.getAllRoutes(id);
      // print('API Response: $response'); // Debug log
      if (response['status'] == true) {
        routeResponse.value = RouteResponse.fromJson(response);
        showRouteDetails.value = true; // Show the route details
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch test centres: ${response['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to reset the test centre form
  void resetTestCentreForm() {
    testCentreId.value = '';
    testCentreName.value = '';
    testCentreAddress.value = '';
    postCode.value = '';
    showAddTestCentreButton.value = true;
  }

  // Set selected test centre for update/delete
  void setSelectedTestCentre(Map<String, dynamic> testCentre) {
    selectedTestCentre.value = testCentre;
  }

  // Method to add a test center
  Future<void> addTestCentre() async {
    isLoading.value = true;
    final data = {
      "name": testCentreName.value,
      "passRate": passRate.value,
      "routes": routes.value,
      "address": testCentreAddress.value,
      "postCode": postCode.value,
    };

    // debugPrint("Data for test center -> $data");

    try {
      final response = await _apiService.addTestCentre(data);
      debugPrint("Response for test center data -> $response");
      if (response['status'] == true) {
        // Store the test center ID and name from the response
        testCentreId.value = response['data']['_id'];
        testCentreName.value = response['data']['name'];
        showAddTestCentre.value = false; // Hide the "Add Test Center" widget
        Get.snackbar('Success', 'Test Centre added successfully');
      } else {
        // Handle specific error messages
        if (response['message'] == "Test centre name already exists") {
          Get.snackbar(
            'Error',
            'A test center with this name already exists. Please choose a different name.',
            duration: const Duration(seconds: 5), // Show for 5 seconds
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to add test centre: ${response['message']}',
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add test centre: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to create a new route
  Future<void> createRoute() async {
    isLoading.value = true;
    final data = {
      "testCentreId": testCentreId.value,
      "routeName": routeName.value,
      "TestCentreName": testCentreName.value,
      "expectedTime": expectedTime.value,
      "shareUrl": shareUrl.value,
      "listOfStops": listOfStops.toList(),
      "startCoordinator": {
        "lat": listOfStops.first['lat'],
        "lng": listOfStops.first['lng'],
      },
      "endCoordinator": {
        "lat": listOfStops.last['lat'],
        "lng": listOfStops.last['lng'],
      },
      "isUser": "admin", // Default value
      "from": from.value,
      "to": to.value,
      "passRate": double.tryParse(passRate.value) ?? 0.0,
      "address": address.value,
      "view": 0, // Default value
      "favorite": [], // Default value
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    };

    try {
      await _apiService.createRoute(data);
      Get.snackbar('Success', 'Route created successfully');

      // Clear the text fields
      clearRouteForm();

      // Navigate back to the "View Test Centres" screen
      showRouteDetails.value = false;
      showAddTestCentreButton.value = false;

      // Refresh the test centres list
      fetchAllTestCentres();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create route: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // In ContentController class
  void setSelectedRouteForEditing(RouteModel route) {
    testCentreId.value = route.testCentreId;
    routeId.value = route.id;
    routeName.value = route.routeName;
    shareUrl.value = route.shareUrl;
    address.value = route.address;
    from.value = route.from;
    to.value = route.to;
    expectedTime.value = route.expectedTime;
    listOfStops.value =
        route.listOfStops.map((stop) {
          return {
            // '_id': stop.id,
            'lat': stop.lat,
            'lng': stop.lng,
          };
        }).toList();

    showAddTestCentreButton.value = true;
    isEditing.value = true;
  }

  Future<void> updateRoute() async {
    try {
      isLoading.value = true;

      final data = {
        "routeName": routeName.value,
        "shareUrl": shareUrl.value,
        "address": address.value,
        "from": from.value,
        "to": to.value,
        "expectedTime": expectedTime.value,
        "listOfStops": listOfStops.toList(),
        "startCoordinator": {
          "lat": listOfStops.first['lat'],
          "lng": listOfStops.first['lng'],
        },
        "endCoordinator": {
          "lat": listOfStops.last['lat'],
          "lng": listOfStops.last['lng'],
        },
      };

      final response = await _apiService.updateRoute(routeId.value, data);

      if (response['status'] == true) {
        Get.snackbar('Success', 'Route updated successfully');
        isEditing.value = false;
        resetRouteForm();
        // Refresh the route list
        await getAllRoutes(testCentreId.value);
      } else {
        throw Exception(response['message'] ?? 'Failed to update route');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update route: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetRouteForm() {
    routeId.value = '';
    routeName.value = '';
    shareUrl.value = '';
    address.value = '';
    from.value = '';
    to.value = '';
    expectedTime.value = 0;
    listOfStops.value = [];
    fileName.value = '';
    isEditing.value = false;
  }

  // Method to clear the route form fields
  void clearRouteForm() {
    routeName.value = '';
    shareUrl.value = '';
    address.value = '';
    fileName.value = '';
    from.value = '';
    to.value = '';
    expectedTime.value = 0;
    listOfStops.value = [];
  }

  void setTestCentreForEditing(TestCentre testCentre) {
    testCentreId.value = testCentre.id;
    testCentreName.value = testCentre.name;
    testCentreAddress.value = testCentre.address;
    postCode.value = testCentre.postCode;
    passRate.value = testCentre.passRate.toString();
    routes.value = testCentre.routes;
    isEditing.value = true;
    showAddTestCentreButton.value = true;
    showRouteDetails.value = false;
  }

  // Cancel editing
  void cancelEditTestCentre() {
    resetTestCentreForm();
    isEditing.value = false;
  }

  // Update test centre
  Future<void> updateTestCentre() async {
    isLoading.value = true;
    // String id = selectedTestCentre['id'];
    // debugPrint("ID for test center -> $id");

    final data = {
      "name": testCentreName.value,
      "address": testCentreAddress.value,
      "postCode": postCode.value,
      "passRate": passRate.value,
      "routes": routes.value,
    };

    debugPrint("Data for test center -> ${testCentreId.value}");

    try {
      final response = await _apiService.updateTestCentre(
        testCentreId.value,
        data,
      );
      if (response['status'] == true) {
        Get.snackbar('Success', 'Test Centre updated successfully');
        await fetchAllTestCentres();
        resetTestCentreForm();
      } else {
        throw Exception(response['message'] ?? 'Failed to update test centre');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update test centre: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete test centre
  Future<void> deleteTestCentre(String id) async {
    isLoading.value = true;
    try {
      final response = await _apiService.deleteTestCentre(id);
      if (response['status'] == true) {
        Get.snackbar('Success', 'Test Centre deleted successfully');
        await fetchAllTestCentres();
        resetTestCentreForm();
      } else {
        throw Exception(response['message'] ?? 'Failed to delete test centre');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete test centre: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      isLoading.value = true;
      final response = await _apiService.deleteRoute(routeId);

      if (response['status'] == true) {
        Get.snackbar('Success', 'Route deleted successfully');
        // Refresh the data
        if (testCentreId.value.isNotEmpty) {
          await getAllRoutes(testCentreId.value);
        }
      } else {
        throw Exception(response['message'] ?? 'Failed to delete route');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete route: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // File picking and parsing logic
  Future<void> pickAndParseGPXFile() async {
    try {
      // Open file picker to select a GPX file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['gpx'],
      );

      if (result != null) {
        // Get the file
        PlatformFile file = result.files.first;

        // Store the picked file name
        fileName.value = file.name;

        // Read the file content (web-specific)
        String fileContent = await _readFileContentWeb(file);

        // Parse the GPX file and extract location information
        List<Map<String, dynamic>> locations = _parseGPXFile(fileContent);

        // Update the reactive list of stops
        listOfStops.value = locations;

        // Calculate total distance and expected time
        double totalDistance = _calculateTotalDistance(locations);
        int calculatedTime = _calculateExpectedTime(totalDistance);

        // Update the expected time
        expectedTime.value = calculatedTime;

        // Extract and fill data from the GPX file
        _fillDataFromGPX(fileContent);

        // Print extracted data for testing
        print('From: ${from.value}');
        print('To: ${to.value}');
        print('Expected Time: $calculatedTime minutes');
        print('List of Stops: $locations');
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking or parsing file: $e');
      Get.snackbar('Error', 'Failed to pick or parse file: $e');
    }
  }

  // Method to read file content on the web
  Future<String> _readFileContentWeb(PlatformFile file) async {
    // Use the file_picker package's built-in file reading for web
    return String.fromCharCodes(file.bytes!);
  }

  // Method to parse GPX file and extract location information
  List<Map<String, dynamic>> _parseGPXFile(String fileContent) {
    try {
      // Parse the XML content
      final document = xml.XmlDocument.parse(fileContent);

      // Extract all <wpt> (waypoints) and <rtept> (route points)
      final waypoints = document.findAllElements('wpt').toList();
      final routePoints = document.findAllElements('rtept').toList();

      // Combine waypoints and route points
      final allPoints = [...waypoints, ...routePoints];

      // Extract latitude, longitude, elevation, and other metadata for each point
      List<Map<String, dynamic>> locations = [];
      for (var point in allPoints) {
        final lat = point.getAttribute('lat');
        final lon = point.getAttribute('lon');
        final ele = point.findElements('ele').singleOrNull?.innerText;
        final name = point.findElements('name').singleOrNull?.innerText;
        final desc = point.findElements('desc').singleOrNull?.innerText;
        final time = point.findElements('time').singleOrNull?.innerText;
        final sym = point.findElements('sym').singleOrNull?.innerText;
        final type = point.findElements('type').singleOrNull?.innerText;

        if (lat != null && lon != null) {
          locations.add({
            'lat': double.parse(lat),
            'lng': double.parse(lon),
            'ele': ele != null ? double.parse(ele) : null,
            'name': name,
            'desc': desc,
            'time': time,
            'sym': sym,
            'type': type,
          });
        }
      }

      return locations;
    } catch (e) {
      print('Error parsing GPX file: $e');
      return [];
    }
  }

  // Method to calculate total distance between waypoints
  double _calculateTotalDistance(List<Map<String, dynamic>> locations) {
    double totalDistance = 0;

    for (int i = 0; i < locations.length - 1; i++) {
      final lat1 = locations[i]['lat'];
      final lon1 = locations[i]['lng'];
      final lat2 = locations[i + 1]['lat'];
      final lon2 = locations[i + 1]['lng'];

      totalDistance += haversineDistance(lat1, lon1, lat2, lon2);
    }

    return totalDistance;
  }

  // Method to calculate expected time based on total distance
  int _calculateExpectedTime(double totalDistance) {
    const double averageSpeed = 50; // Average speed in km/h
    double timeInHours = totalDistance / averageSpeed;
    return (timeInHours * 60).round(); // Convert hours to minutes
  }

  // Method to fill data from the GPX file
  void _fillDataFromGPX(String fileContent) {
    try {
      final document = xml.XmlDocument.parse(fileContent);

      // Extract start and end points (if available)
      final waypoints = document.findAllElements('wpt').toList();
      if (waypoints.isNotEmpty) {
        final startPoint = waypoints.first;
        final endPoint = waypoints.last;

        from.value =
            startPoint.findElements('name').firstOrNull?.innerText ?? 'Start';
        to.value =
            endPoint.findElements('name').firstOrNull?.innerText ?? 'End';
      }
    } catch (e) {
      print('Error filling data from GPX file: $e');
    }
  }

  // Haversine formula to calculate distance between two points
  double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    // Haversine formula
    double a =
        pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distance in kilometers
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }
}
