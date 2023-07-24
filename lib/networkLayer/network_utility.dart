import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_local_db.dart';

import '../Utility/app_exception.dart';

class AppNetworkUtility {
  static Map<String, dynamic> responseHandler(Response<dynamic> response) {
    if (response.body != null) {
      var responseCode = response.statusCode ?? 0;

      if (responseCode >= 200 && responseCode < 300) {
        // success response
        debugPrint("token+ ${AppPreference().token}");
        return response.body;
      }
      else if (responseCode == 422 ) {
        // bad auth header
        throw ServerException(response.body["msg"]);
      }
      else if ( responseCode == 401) {
        // bad auth header
        throw ServerException(response.body["errors"].first);
      }
      else if (responseCode >= 400 && responseCode <= 500) {
        // token exception
        String errorMessage = response.body["errors"];
        debugPrint("errorMessage${errorMessage}");
       // WidgetUtil.showSnackBar(errorMessage);
        throw ServerException(errorMessage);
      } else if (responseCode == 501) {
        throw ServerException(response.body);
      } else {
        // common error like validation
        throw ValidationException(response.bodyString);
      }
    } else {
      throw ConnectivityException();
    }
  }
}
