class APIBase {
  static String get productionURL {
    return '';
  }

  static String get developmentURL {
    return "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1";
  }
}

class APIPathHelper {
  APIPathHelper();

  //Auth

 String validateUserEmailForSignUp =
      '${APIBase.developmentURL}/auth/email';
  String submitOtpForSignup =
      '${APIBase.developmentURL}/auth/email/verify';
  String registerUser = '${APIBase.developmentURL}/auth/register';
  String signInUser = '${APIBase.developmentURL}/auth/login';
  
}
