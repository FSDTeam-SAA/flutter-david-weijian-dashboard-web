import 'package:david_weijian_dashboard/constants/key_constants.dart';

class AuthResponse {
  final bool status;
  final String message;
  final String? accessToken;

  AuthResponse({required this.status, required this.message, this.accessToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'],
      message: json['message'],
      accessToken: json[KeyConstants.accessToken],
    );
  }
}
