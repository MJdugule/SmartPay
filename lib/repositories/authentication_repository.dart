import 'package:smartpay/data/network_service.dart';
import 'package:smartpay/models/auth_user.dart';

class AuthenticationRepository {
  AuthenticationRepository();
  Future validateEmailForSignUpProcess(String email) {
    return NetworkService().validateUserEmailSignup(email);
  }

  Future submitOTPDataForSignUp(String email, String token) {
    return NetworkService().submitOTPDataForSignUp(email, token);
  }

  Future submitUserDetailsForSignUp(AuthUser authUser) {
    return NetworkService().submitUserDetailsForSignUp(authUser);
  }

  Future submitUserDetailsForSignIn(AuthUser authUser) {
    return NetworkService().submitUserDetailsForSignIn(authUser);
  }

  Future getUser() {
    return NetworkService().getUser();
  }

  // Future signOutUser() {
  //   return NetworkService().logoutUser();
  // }

  // Future deleteUserAccount() {
  //   return NetworkService().deleteUserAccount();
  // }
}
