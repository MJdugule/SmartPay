import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/main.dart';
import 'package:smartpay/models/auth_user.dart';
import 'package:smartpay/models/country_code.dart';
import 'package:smartpay/models/validation_model.dart';
import 'package:smartpay/repositories/authentication_repository.dart';
import 'package:smartpay/utilities/pref_utils.dart';
import 'package:smartpay/utilities/snackbar_utils.dart';
import 'package:smartpay/utilities/user_secure_storage.dart';
import 'package:smartpay/views/auth/auth_pin/set_pin_screen.dart';
import 'package:smartpay/views/auth/register/verify_otp_screen.dart';
import 'package:smartpay/views/auth/register/auth_profile_screen.dart';
import 'package:smartpay/views/dashboard/home_screen.dart';
import 'package:smartpay/views/dashboard/success_screen.dart';
import 'package:smartpay/views/intro_screens/onboarding_screen.dart';

class AuthenticationProvider extends ChangeNotifier {
  String _selectedCountryName = "Select Country";
  String _selectedCountryFlagTwo = "";
  CountryCode? _selectedCountry;
  ValidationModel _email = ValidationModel(value: null, error: null);
  ValidationModel _password = ValidationModel(value: null, error: null);
  ValidationModel _fullName = ValidationModel(value: null, error: null);
  ValidationModel _username = ValidationModel(value: null, error: null);
  ValidationModel _otp = ValidationModel(value: null, error: null);

  CountryCode? get selectedCountry => _selectedCountry;
  String get selectedCountryFlagTwo => _selectedCountryFlagTwo;
  String get selectedCountryName => _selectedCountryName;
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get fullName => _fullName;
  ValidationModel get username => _username;
  ValidationModel get otp => _otp;

  bool _loading = false;
  bool get loading => _loading;
  bool _resendOtp = false;
  bool get resendOtp => _resendOtp;
  bool _resending = false;
  bool get resending => _resending;

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

// loader
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

// Otp Loader
  setOTP(bool resendOTP, {bool? resending}) async {
    _resendOtp = resendOTP;
    _resending = resending!;

    notifyListeners();
  }

  // Validate Email textfield
  void validateEmail(String emailText) {
    if (emailText.isEmpty) {
      _email = ValidationModel(value: null, error: kEmptyEmailError);
    } else if (!(regexEmail.hasMatch(emailText))) {
      _email = ValidationModel(value: null, error: kInvalidEmailError);
    } else {
      _email = ValidationModel(value: emailText, error: null);
    }
    notifyListeners();
  }

  //Validate Fullname textfield
  void validateFullName(String fullNameText) {
    if (fullNameText.isEmpty) {
      _fullName = ValidationModel(value: null, error: 'Full name is required');
    } else if (!(fullNameText.length >= 2)) {
      _fullName =
          ValidationModel(value: null, error: 'Must be at least 2 characters');
    } else if (!(regexName.hasMatch(fullNameText))) {
      _fullName =
          ValidationModel(value: null, error: 'Please enter a valid full name');
    } else {
      _fullName = ValidationModel(value: fullNameText, error: null);
    }
    notifyListeners();
  }

  //Validate username textfield
  void validateUserName(String usernameText) {
    if (usernameText.isEmpty) {
      _username = ValidationModel(value: null, error: null);
    } else if (!(usernameText.length >= 2)) {
      _username =
          ValidationModel(value: null, error: 'Must be at least 2 characters');
    } else if (!(regexName.hasMatch(usernameText))) {
      _username = ValidationModel(
          value: null, error: 'Please enter a valid Username name');
    } else {
      _username = ValidationModel(value: usernameText, error: null);
    }
    notifyListeners();
  }

  // Validate Otp fields
  bool validateOtpField(String otp) {
    bool valid = false;

    if (otp.isEmpty) {
      valid = false;
      _otp = ValidationModel(value: null, error: 'OTP is required');
    } else if (!otp.contains(regexOTP)) {
      valid = false;
      _otp = ValidationModel(value: null, error: 'OTP is invalid');
    } else if (otp.length < 5) {
      valid = false;
      _otp = ValidationModel(
          value: null, error: 'OTP must not be less than 5 digits');
    } else {
      valid = true;
      _otp = ValidationModel(value: otp.trim(), error: null);
    }
    notifyListeners();

    return valid;
  }

  //Validate password textfield
  void validateSignUpPassword(String passwordText) {
    if (passwordText.isEmpty) {
      _password = ValidationModel(value: null, error: kEmptyPasswordError);
    } else if (!(passwordText.length >= 6)) {
      _password =
          ValidationModel(value: null, error: 'Must be at least 6 characters');
    } else if (!passwordText.contains(regexUpperCase, 0)) {
      _password = ValidationModel(
          value: null, error: "Password must contain an uppercase");
    } else if (!passwordText.contains(RegExp(r'[a-z]'), 0)) {
      _password = ValidationModel(
          value: null, error: "Password must contain a lowercase");
    } else if (!passwordText.contains(RegExp(r'[0-9]'), 0)) {
      _password =
          ValidationModel(value: null, error: "Password must contain a number");
    } else {
      _password = ValidationModel(value: passwordText, error: null);
    }
    notifyListeners();
  }

  void setCountry(CountryCode value) {
    _selectedCountryName = value.countryName;
    _selectedCountryFlagTwo = value.countryFlag;
    _selectedCountry = value;
  }

  // Get validated email value
  bool get isValidEmail {
    return _email.value != null;
  }

  // Get validated otp value
  bool get isValidOtp {
    return _otp.value != null;
  }

  bool get isValidRegProfile {
    return _email.value != null &&
        _password.value != null &&
        _fullName.value != null &&
        _selectedCountry != null;
    //  _email.value != null&&
  }

  bool get isValidSignIn {
    return _email.value != null && _password.value != null;
  }

  // Submit Email to get otp
  Future submitEmailForSignUp() async {
    setLoading(true);
    final status = await authenticationRepository
        .validateEmailForSignUpProcess('${email.value}');
    if (status == true) {
      setOTP(true, resending: false);
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const VerifyOtpScreen()),
      );
      setLoading(false);
    } else {
      setLoading(false);
      setOTP(false, resending: false);
    }

    setLoading(false);
    return status;
  }

  //Submit user details for sign up
  Future submitUserDetailsForSignUp() async {
    setLoading(true);
    AuthUser user = AuthUser(
        email: _email.value,
        password: _password.value,
        username: _username.value,
        fullName: _fullName.value,
        country: _selectedCountry!.countryIsoCode);
    final status =
        await authenticationRepository.submitUserDetailsForSignUp(user);
    // print(status);
    if (status == true) {
      UserSecureStorage.setPasswordKey(_password.value.toString());
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const SetPinScreen()),
      );
      setLoading(false);
    }

    setLoading(false);
    return status;
  }

  //Verify Otp
  Future submitOTPDataForSignUp() async {
    setLoading(true);
    final status = await authenticationRepository.submitOTPDataForSignUp(
        email.value.toString(), otp.value.toString());
    if (status == true) {
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const AuthProfileScreen()),
      );
      setLoading(false);
    }

    setLoading(false);
    return status;
  }

  // Resend Otp
  Future resendOtpForSignUp() async {
    final status = await authenticationRepository
        .validateEmailForSignUpProcess('${email.value}');
    if (status == true) {
      setOTP(true, resending: false);
    } else {
      setOTP(false, resending: false);
    }

    setLoading(false);
    return status;
  }

  //Submit user details for sign up
  Future submitUserDetailsForSignIn() async {
    setLoading(true);
    AuthUser user = AuthUser(
      email: _email.value,
      password: _password.value,
    );
    final status =
        await authenticationRepository.submitUserDetailsForSignIn(user);
    // print(status);
    if (status == true) {
      UserSecureStorage.setPasswordKey(_password.value.toString());
      String pin = await AuthenticationProvider().getPassKey();
      if (pin == "") {
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const SetPinScreen()),
        );
      } else {
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
        );
      }

      setLoading(false);
    }

    setLoading(false);
    return status;
  }

   Future getUser() async {
    setLoading(true);
    final status =
        await authenticationRepository.getUser();
    if(status != null) {
    if (status != false) {
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) =>  HomeScreen(welcomeText: status["data"]["secret"],)),
      );
      setLoading(false);
    }}

    setLoading(false);
    return status;
  }

  Future checkPassPin(String pin) async {
    setLoading(true);
    String securedPin = await getPassKey();
    if (pin == securedPin) {
      getUser();
  }else{
    setLoading(false);
    showError("Your Smartpay pin was incorrect. Please try again");
  }
  
  }

  void clearAppDetaills() {
    setLoading(true);

    navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const OnboardingScreen();
      },
    ), (route) => false);
    UserSecureStorage.deleteUserDetails();
    PrefUtils.deleteUserFromMemory();
    setLoading(false);
  }

  Future<String> getUserAuthKeys() async {
    String tokens = await UserSecureStorage.getUserCredentials();

    return tokens;
  }

  setChangePassKey(String pin) async {
    await UserSecureStorage.setPinKey(pin);
    navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => const SuccessScreen()),
    );
  }

  Future<String> getPassKey() async {
    String? token = await UserSecureStorage.getPinKey();
    return token.toString();
  }

  Future removeUserDataAfterLogout() async {
    await UserSecureStorage.deleteUserDetails();

    PrefUtils.deleteUserFromMemory();
  }

  void showError(String message) {
    SPSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }
}
