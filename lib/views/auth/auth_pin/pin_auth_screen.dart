import 'package:flutter/material.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/utilities/dialog_utils.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';

class PinAuthScreen extends StatefulWidget {
  const PinAuthScreen({super.key});

  @override
  State<PinAuthScreen> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
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
            verticalSpaceLarge,
            RichText(
              text: TextSpan(
                  text: 'Enter your ',
                  style: kLargeTextStyle.copyWith(
                    fontSize: 24,
                    // height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'SmartPay ',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 24,
                        color: AppColor.kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Pin',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 24,
                        // height: 1.5,
                      ),
                    ),
                  ]),
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SPOtpInputFieldTwo(
                  autoFocus: true,
                  focusNode: _otpOneFocusNode,
                  onChanged: (value) {
                    authenticationProvider.validateOtpField(value);
                  },
                  textEditingController: _otpOneController,
                ),
                SPOtpInputFieldTwo(
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
                SPOtpInputFieldTwo(
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
                SPOtpInputFieldTwo(
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
                SPOtpInputFieldTwo(
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
                      await authenticationProvider.checkPassPin(otp);
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
            verticalSpaceRegular,
            GestureDetector(
              onTap: () async {
                final status =
                    await DialogUtilities().showForgotPinDialog(context);
                if (status == true) {
                  authenticationProvider.clearAppDetaills();
                }
              },
              child: Center(
                child: Text(
                  'Forgot your pin?',
                  style: kRegularTextStyle.copyWith(
                      color: AppColor.kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
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
