

class ApiConstants {
  // Access the base URL from the .env file
  static final String baseUrl = 'https://backend-david-weijian.onrender.com/api/v1';

  static String get adminLoginEndpoint => '$baseUrl/admin/login';
  static String get usersEndpoint => '$baseUrl/admin/all-users';

  static String get contactDetailsEndpoint => '$baseUrl/admin/contact-details';
  static String get bugReportEndpoint => '$baseUrl/admin/bug-report';
  static String get allReviewsEndpoint => '$baseUrl/admin/all-review';

  static String get testCentresEndpoint => '$baseUrl/admin/all-test-centre';

  static String get routesEndpoint => '$baseUrl/route-details/route';

  // post
  static String get addTestCentreEndpoint => '$baseUrl/admin/add-test-centre';
  static String get createRouteEndpoint => '$baseUrl/admin/create-route';

  // put
  static String get updateTestCentreEndpoint => '$baseUrl/admin/update-test-centre';
  static String get updateRouteEndpoint => '$baseUrl/admin/update-route/';

  // delete
  static String get deleteTestCentreEndpoint => '$baseUrl/admin/delete-test-centre';
  static String get deleteRouteEndpoint => '$baseUrl/admin/delete-route';

}
