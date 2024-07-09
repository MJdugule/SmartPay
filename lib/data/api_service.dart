import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/repositories/internet_repository.dart';
import 'package:smartpay/utilities/exception.dart';
import 'package:smartpay/utilities/snackbar_utils.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';


class ApiService {
  Future<Either<dynamic, dynamic>> apiInterceptor(Function function) async {
    await InternetChecker().checkInternetStatus();
    try {
      var response = await function.call();
      final errorMessage =
          ApiException.fromResponse(response.statusCode, response);
      if (errorMessage.toString() != "null") {
        if (errorMessage.toString().toLowerCase() == "jwt expired" || errorMessage.toString().toLowerCase() == "invalid or expired token") {
          AuthenticationProvider().clearAppDetaills();
          return Left(response);
        }
        showError(errorMessage.toString());
        return Left(response);
      }else{
      //  checkAndStoreToken(response);
         return Right(response);
      }
     
    } 
    on SocketException {
      showError(kInternetErrorMessage);
      return const Left(null);
    } on HttpException {
      showError("Something went wrong");
      return const Left(null);
    } on FormatException {
      showError("An error occurred");
      return const Left(null);
    } on TimeoutException{
       showError("Unable to reach the server, check your internet connection and try again");
      return const Left(null);
    }
    on HandshakeException{
      showError("An Internet error occurred, please try again later");
      return const Left(null);
    } on Exception {
      showError("Oops, something went wrong please try again later");
      return const Left(null);
    } catch (e) {
     
      return const Left(null);
    }
    
    
  }

   void showError(String message) {
    SPSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }
  
}
