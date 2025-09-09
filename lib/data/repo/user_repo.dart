import 'package:mytodo/data/datasources/remote/base/api_response.dart';
import 'package:mytodo/data/datasources/remote/user_api.dart';
import 'package:mytodo/data/model/response/users/get_user_by_email_res.dart';
import 'package:mytodo/data/model/response/users/notification_res.dart';
import 'package:mytodo/data/model/response/users/verification_status.dart';
import 'package:mytodo/data/model/response/users/verify_identity_res.dart';
import 'package:mytodo/data/model/user_model.dart';

import '../../core/cores.dart';

class UserRepo {
  final _userApi = UserApi();

  Future<ApiResponse<User?>> getUser({required String id}) async {
    final res = await _userApi.getUser(id: id);
    if (res.success) {
      appLocalStorage.saveUser(res.data!);
      appGlobals.user = res.data!;
    }
    return res;
  }

  Future<ApiResponse<VerificationStatusResponse?>>
  getVerificationStatus() async {
    return _userApi.getVerificationStatus();
  }

  Future<ApiResponse<VerifyIdentityRes>> verifyIdentity({
    required String type,
    required String number,
  }) async {
    return _userApi.verifyIdentity(type: type, number: number);
  }

  Future<ApiResponse> verifyIdentityToken({
    required String type,
    required String number,
  }) async {
    return _userApi.verifyIdentityToken(type: type, number: number);
  }

  Future<ApiResponse<List<NotificationRes>?>> getNotifications() async {
    return _userApi.getNotifications();
  }

  Future<ApiResponse<GetUserByEmailResponse?>> getUserbyEmail({
    required String email,
  }) async {
    return _userApi.getUserbyEmail(email: email);
  }

  Future<ApiResponse> resendVerifyIdentityToken({required String type}) async {
    return _userApi.resendVerifyIdentityToken(type: type);
  }
}
