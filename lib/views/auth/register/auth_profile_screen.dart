import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/country_picker.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';

class AuthProfileScreen extends StatefulWidget {
  const AuthProfileScreen({super.key});

  @override
  State<AuthProfileScreen> createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        padding: safeAreaPadding,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPBackButton(
                  pressState: () {
                    Navigator.of(context).pop();
                  },
                ),
                verticalSpaceMedium,
                verticalSpaceTiny,
                RichText(
                  text: TextSpan(
                      text: 'Hey there! tell us a bit \nabout ',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 24,
                        // height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'yourself ',
                          style: kLargeTextStyle.copyWith(
                            fontSize: 24,
                            color: AppColor.kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                ),
                verticalSpaceMedium,
                verticalSpaceTiny,
                SPTextField(
                  hintText: 'Full name',
                  errorText: authenticationProvider.fullName.error,
                  controller: fullNameController,
                  onChanged: (value) =>
                      authenticationProvider.validateFullName(value),
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                verticalSpaceSmall,
                SPTextField(
                  hintText: 'Username',
                  errorText: authenticationProvider.username.error,
                  controller: userNameController,
                  onChanged: (value) =>
                      authenticationProvider.validateUserName(value),
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                verticalSpaceSmall,
                SPCountryDropDown(
                    // currentValue: countryCode,
                    onChanged: (value) =>
                        authenticationProvider.setCountry(value),
                    countryName: authenticationProvider.selectedCountryName,
                    countryFlag: authenticationProvider.selectedCountryFlagTwo),
                verticalSpaceTiny,
                SPPasswordField(
                  hintText: 'Password',
                  errorText: authenticationProvider.password.error,
                  controller: passwordController,
                  onChanged: (value) =>
                      authenticationProvider.validateSignUpPassword(value),
                  textInputAction: TextInputAction.done,
                ),
                verticalSpaceMedium,
                authenticationProvider.loading
                    ? const Center(child: AppSpinner())
                    : SPFlatButton(
                        pressState: () async {
                          if (!authenticationProvider.isValidRegProfile) {
                            // authenticationProvider
                            //     .validateEmail(emailController.text);
                            return;
                          }

                          FocusScope.of(context).unfocus();
                          await authenticationProvider
                              .submitUserDetailsForSignUp();
                        },
                        active: authenticationProvider.isValidRegProfile,
                        textColor: kWhite,
                        text: "Continue",
                        buttonColor: AppColor.kGreyNeutral,
                      ),
                verticalSpaceMedium
              ],
            ),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
