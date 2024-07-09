import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartpay/data/api_service.dart';
import 'package:smartpay/data/api_urls.dart';
import 'package:smartpay/models/auth_user.dart';
import 'package:smartpay/utilities/exception.dart';
import 'package:smartpay/utilities/pref_utils.dart';
import 'package:smartpay/utilities/snackbar_utils.dart';
import 'package:smartpay/utilities/user_secure_storage.dart';

class NetworkService {
  ApiService apiService = ApiService();
  void showError(String message) {
    SPSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }

  // Submiit email for signup
  Future validateUserEmailSignup(String email) async {
    var res = await apiService.apiInterceptor(() async {
      var httpResponse = await http.post(
        Uri.parse(APIPathHelper().validateUserEmailForSignUp),
        body: {
          "email": email,
        },
      );
      final errorMessage =
          ApiException.fromResponse(httpResponse.statusCode, httpResponse);
      if (errorMessage.toString() != "null") {
        showError(errorMessage.toString());
      }
      return httpResponse;
    });
    return res.fold((l) => false, (r) {
      return true;
    });
  }

  //Submit Otp for signup
  Future submitOTPDataForSignUp(String email, String token) async {
    var res = await apiService.apiInterceptor(() async {
      var httpResponse = await http.post(
        Uri.parse(APIPathHelper().submitOtpForSignup),
        body: {
          "email": email,
          "token": token,
        },
      );
      final errorMessage =
          ApiException.fromResponse(httpResponse.statusCode, httpResponse);
      if (errorMessage.toString() != "null") {
        showError(errorMessage.toString());
      }
      return httpResponse;
    });
    return res.fold((l) => false, (r) {
      return true;
    });
  }

  //Submit user details for signup
  Future submitUserDetailsForSignUp(AuthUser authUser) async {
    // print(authUser.fullName);
    var res = await apiService.apiInterceptor(() async {
      var httpResponse =
          await http.post(Uri.parse(APIPathHelper().registerUser), body: {
        'full_name': authUser.fullName.toString(),
        'email': authUser.email.toString(),
        'country': authUser.country.toString(),
        'password': authUser.password.toString(),
        "username": authUser.username ?? "",
        'device_name': 'mobile'
      });
      final errorMessage =
          ApiException.fromResponse(httpResponse.statusCode, httpResponse);
      if (errorMessage.toString() != "null") {
        showError(errorMessage.toString());
      }
      // print(httpResponse);
      return httpResponse;
    });
    return res.fold((l){
      // print(l);
      return false;
    } , (r) {
      var userResponse = jsonDecode(r.body);
      UserSecureStorage.setUserCredentials(userResponse["data"]["token"]);
      PrefUtils.setUserData(r.body);
      return true;
    });
  } 
  
  //Submit user details for signin
  Future submitUserDetailsForSignIn(AuthUser authUser) async {
    // print(authUser.fullName);
    var res = await apiService.apiInterceptor(() async {
      var httpResponse =
          await http.post(Uri.parse(APIPathHelper().signInUser), body: {
        
        'email': authUser.email.toString(),
        
        'password': authUser.password.toString(),
        
        'device_name': 'mobile'
      });
      final errorMessage =
          ApiException.fromResponse(httpResponse.statusCode, httpResponse);
      if (errorMessage.toString() != "null") {
        showError(errorMessage.toString());
      }
      // print(httpResponse);
      return httpResponse;
    });
    return res.fold((l){
      // print(l);
      return false;
    } , (r) {
      var userResponse = jsonDecode(r.body);
      UserSecureStorage.setUserCredentials(userResponse["data"]["token"]);
      PrefUtils.setUserData(r.body);
      return true;
    });
  }
}
