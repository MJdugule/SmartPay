import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/animation_widget.dart';
import 'package:smartpay/utilities/pref_utils.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';
import 'package:smartpay/views/auth/login/login_screen.dart';
import 'package:smartpay/views/auth/auth_pin/pin_auth_screen.dart';
import 'package:smartpay/views/intro_screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 2),
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    animation = fadeSlideTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.fastLinearToSlowEaseIn),
    ));

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    _checkSessions();
  }

  Future<bool> _checkSessions() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {
      isFirstTime().then((value) {
        value
            ? _navigateToOnBoard()
            : isLoggedIn().then((value) {
                value ? getPin().then((value) {
                  value ? _navigateToPin() : _navigateToSignIn();
                }) : _navigateToSignIn();
              });
        //print(value);
      });
    });
    return true;
  }

  _navigateToPin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const PinAuthScreen()));
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen()));
  }

  Future<bool> isLoggedIn() async {
    String authKeys = await AuthenticationProvider().getUserAuthKeys();
    if (authKeys == "") {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getPin() async {
    String pin = await AuthenticationProvider().getPassKey();
    if (pin == "") {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isFirstTime() async {
    var isUserFirstTime = PrefUtils.getIsUserFirstTimeInApp();
    if (isUserFirstTime != null && !isUserFirstTime) {
      PrefUtils.putUserFirstTimeInApp(false);
      return false;
    } else {
      PrefUtils.putUserFirstTimeInApp(false);
      return true;
    }
  }

  void _navigateToOnBoard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const OnboardingScreen()));
  }

  // void _navigateToDashboard() {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (BuildContext context) => const DashBoard()));
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  kSplashLogo,
                  height: 72,
                  width: 72,
                  fit: BoxFit.contain,
                ),
                verticalSpaceSmall,
                FadeSlideTransition(
                  additionalOffset: 0.0,
                  animation: animation,
                  child: RichText(
                      text: TextSpan(
                          text: 'Smart',
                          style: kLargeTextStyle.copyWith(fontSize: 30),
                          children: [
                        TextSpan(
                          text: 'pay.',
                          style: kLargeTextStyle.copyWith(
                              color: AppColor.kPrimaryColor, fontSize: 30),
                        )
                      ])),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
