import 'package:mytodo/core/di/locator.dart';
import 'package:mytodo/data/datasources/remote/base/api_failure.dart';
import 'package:mytodo/data/datasources/remote/base/api_response.dart';
import 'package:mytodo/data/datasources/remote/base/api_service.dart';
import 'package:mytodo/data/model/response/users/get_user_by_email_res.dart';
import 'package:mytodo/data/model/response/users/notification_res.dart';
import 'package:mytodo/data/model/response/users/verification_status.dart';
import 'package:mytodo/data/model/response/users/verify_identity_res.dart';
import 'package:mytodo/data/model/user_model.dart';

class UserApi {
  final _apiService = ApiService(path: '/users');

  Future<ApiResponse<User?>> getUser({required String id}) async {
    try {
      final res = await _apiService.get("/$id");
      return ApiResponse.fromJson(res)..data = User.fromJson(res['data']);
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  Future<ApiResponse<GetUserByEmailResponse?>> getUserbyEmail({
    required String email,
  }) async {
    try {
      final res = await _apiService.get(
        "/get-by-email",
        queryParams: {'email': email},
      );
      return ApiResponse.fromJson(res)
        ..data = GetUserByEmailResponse.fromJson(res['data']);
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  Future<ApiResponse<VerificationStatusResponse?>>
  getVerificationStatus() async {
    try {
      final res = await _apiService.get("/verification-status");
      return ApiResponse.fromJson(res)
        ..data = VerificationStatusResponse.fromJson(res);
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  Future<ApiResponse<VerifyIdentityRes>> verifyIdentity({
    required String type,
    required String number,
  }) async {
    try {
      final res = await _apiService.post(
        "/verify-identity",
        data: {"type": type, "number": number},
      );
      return ApiResponse.fromJson(res)
        ..success = true
        ..message = "Success"
        ..data = VerifyIdentityRes.fromJson(res);
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  Future<ApiResponse> verifyIdentityToken({
    required String type,
    required String number,
  }) async {
    try {
      final res = await _apiService.post(
        "/verify-identity-token",
        data: {"type": type, "number": number},
      );
      return ApiResponse.fromJson(res)
        ..success = true
        ..message = "Success";
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  Future<ApiResponse> resendVerifyIdentityToken({required String type}) async {
    try {
      final res = await _apiService.post(
        "/resend-verify-identity-token",
        data: {"type": type},
      );
      return ApiResponse.fromJson(res)
        ..success = true
        ..message = "Success";
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }

  ///List of notification
  Future<ApiResponse<List<NotificationRes>?>> getNotifications() async {
    try {
      final res = await _apiService.get(
        '/${appGlobals.user?.id}/notifications',
      );
      //final resMap = {"data": res};
      return ApiResponse.fromJson(res)
        ..data = (res['data'] as List)
            .map((e) => NotificationRes.fromJson(e))
            .toList();
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    }
  }
}
