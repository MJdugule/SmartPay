import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/utilities/helper.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpOneController = TextEditingController();
  final _otpTwoController = TextEditingController();
  final _otpThreeController = TextEditingController();
  final _otpFourController = TextEditingController();
  final _otpFiveController = TextEditingController();

  final _otpOneFocusNode = FocusNode();
  final _otpTwoFocusNode = FocusNode();
  final _otpThreeFocusNode = FocusNode();
  final _otpFourFocusNode = FocusNode();
  final _otpFiveFocusNode = FocusNode();

  @override
  void dispose() {
    _otpOneController.dispose();
    _otpTwoController.dispose();
    _otpThreeController.dispose();
    _otpFourController.dispose();
    _otpFiveController.dispose();
    _otpOneFocusNode.dispose();
    _otpTwoFocusNode.dispose();
    _otpThreeFocusNode.dispose();
    _otpFourFocusNode.dispose();
    _otpFiveFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPBackButton(pressState: () {
              Navigator.pop(context);
            }),
            verticalSpaceMedium,
            Text(
              "Verify it's you",
              style: kLargeTextStyle.copyWith(
                fontSize: 24,
                // height: 1.5,
              ),
            ),
            verticalSpaceSmall,
            RichText(
              text: TextSpan(
                  text: 'We have sent a code to: ',
                  style: kRegularTextStyle.copyWith(fontSize: 16),
                  children: [
                    TextSpan(
                        text: '${authenticationProvider.email.value}. ',
                        style: kRegularTextStyle.copyWith(
                            fontSize: 16, color: AppColor.kPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // OpenMail().openChosenEmailApp(context);
                          }),
                    TextSpan(
                        text: 'Enter it here to verify your identity',
                        style: kRegularTextStyle.copyWith(fontSize: 16),
                       ),
                  ]),
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SPOtpInputField(
                  autoFocus: true,
                  focusNode: _otpOneFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                  },
                  textEditingController: _otpOneController,
                ),
                SPOtpInputField(
                  focusNode: _otpTwoFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textEditingController: _otpTwoController,
                ),
                SPOtpInputField(
                  focusNode: _otpThreeFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textEditingController: _otpThreeController,
                ),
                SPOtpInputField(
                  focusNode: _otpFourFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textEditingController: _otpFourController,
                ),
                SPOtpInputField(
                  focusNode: _otpFiveFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textEditingController: _otpFiveController,
                ),
              ],
            ),
            verticalSpaceMedium,
            authenticationProvider.resendOtp == false
                ? Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Didn't get code? ",
                            style: kLargeTextStyle.copyWith(
                                fontSize: 17,
                                color: AppColor.kGreyNeutral.shade500),
                            children: [
                              authenticationProvider.resending == true
                                  ? TextSpan(
                                      text: "Resending",
                                      style: kLargeTextStyle.copyWith(
                                        fontSize: 16,
                                        color: AppColor.kPrimaryColor,
                                        // fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : TextSpan(
                                  text: "Resend",
                                  style: kLargeTextStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColor.kPrimaryColor,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      authenticationProvider.setOTP(false,
                                          resending: true);
                                      await authenticationProvider
                                          .resendOtpForSignUp();
                                      
                                    })
                            ])),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 5, left: kPaddingFIVE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resend Code in ",
                          style: kLargeTextStyle.copyWith(
                              fontSize: 17,
                              color: AppColor.kGreyNeutral.shade500),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 30.0, end: 0.00),
                          duration: const Duration(seconds: 30),
                          builder: (context, value, child) => Text(
                            '00:${Helper().twoDigits(value.toInt())}',
                            style: kLargeTextStyle.copyWith(
                              fontSize: 16,
                              color: AppColor.kPrimaryColor,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                          onEnd: () {
                            authenticationProvider.setOTP(false,
                                resending: false);
                          },
                        ),
                        Text(
                          " secs",
                          style: kLargeTextStyle.copyWith(
                              fontSize: 17,
                              color: AppColor.kGreyNeutral.shade500),
                        ),
                      ],
                    ),
                  ),
             const Spacer(),
            authenticationProvider.loading
                ? const Center(child: AppSpinner())
                : SPFlatButton(
                    active: authenticationProvider.isValidOtp,
                    pressState: () async {
                      String otp = _otpOneController.text +
                          _otpTwoController.text +
                          _otpThreeController.text +
                          _otpFourController.text +
                          _otpFiveController.text;
                      if (!authenticationProvider.validateOtpField(otp)) {
                        // authenticationProvider.showErrorMessage(
                        //     'Please complete OTP form thoroughly to proceed.');
                        return;
                      }
                      await authenticationProvider.submitOTPDataForSignUp();
                    },
                    textColor: kWhite,
                    text: "Confirm",
                    buttonColor: AppColor.kGreyNeutral,
                  ),
            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: NumericKeyboard(
                onKeyboardTap: (String value) {
                  setState(() {
                    if (_otpOneController.text.isEmpty) {
                      _otpOneController.text = value;
                      FocusScope.of(context).requestFocus(_otpTwoFocusNode);
                    } else if (_otpTwoController.text.isEmpty) {
                      _otpTwoController.text = value;
                      FocusScope.of(context).requestFocus(_otpThreeFocusNode);
                    } else if (_otpThreeController.text.isEmpty) {
                      _otpThreeController.text = value;
                      FocusScope.of(context).requestFocus(_otpFourFocusNode);
                    } else if (_otpFourController.text.isEmpty) {
                      _otpFourController.text = value;
                      FocusScope.of(context).requestFocus(_otpFiveFocusNode);
                    } else if (_otpFiveController.text.isEmpty) {
                      _otpFiveController.text = value;
                    }
                  });
                  String otp = _otpOneController.text +
                      _otpTwoController.text +
                      _otpThreeController.text +
                      _otpFourController.text +
                      _otpFiveController.text;
                  authenticationProvider.validateOtpField(otp);
                },
                textStyle: kLargeTextStyle.copyWith(fontSize: 23),
                rightButtonFn: () {
                  setState(() {
                    if (_otpFiveController.text.isNotEmpty) {
                      _otpFiveController.clear();
                    } else if (_otpFourController.text.isNotEmpty) {
                      _otpFourController.clear();
                      FocusScope.of(context).requestFocus(_otpFourFocusNode);
                    } else if (_otpThreeController.text.isNotEmpty) {
                      _otpThreeController.clear();
                      FocusScope.of(context).requestFocus(_otpThreeFocusNode);
                    } else if (_otpTwoController.text.isNotEmpty) {
                      _otpTwoController.clear();
                      FocusScope.of(context).requestFocus(_otpTwoFocusNode);
                    } else if (_otpOneController.text.isNotEmpty) {
                      _otpOneController.clear();
                      FocusScope.of(context).requestFocus(_otpOneFocusNode);
                    }
                  });
                  String otp = _otpOneController.text +
                      _otpTwoController.text +
                      _otpThreeController.text +
                      _otpFourController.text +
                      _otpFiveController.text;
                  authenticationProvider.validateOtpField(otp);
                },
                rightIcon: const Icon(
                  Icons.backspace_outlined,
                  // color: Colors.red,
                ),
              ),
            ),
            verticalSpaceMedium
          ],
        ),
      ),
    );
  }
}
