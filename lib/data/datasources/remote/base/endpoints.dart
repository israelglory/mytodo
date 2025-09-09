import 'package:flutter/foundation.dart';

class Endpoints {
  //static const baseUrl = 'https://payme-api-dev.systemshift.africa';
  //LiVE ENDPOINT
  static const baseUrl = kDebugMode
      ? 'https://grow-funds-api-d9778ca4d8f0.herokuapp.com/v1'
      : 'https://api.mcopenny.ng/v1';
}
