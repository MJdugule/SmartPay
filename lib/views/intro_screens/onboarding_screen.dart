import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/models/onboarding.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/onboarding_widget.dart';
import 'package:smartpay/res/widget/page_list_indicator.dart';
import 'package:smartpay/views/auth/login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>{
  
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Onboarding> onBoardingList = Onboarding.list;

  _navigateToSignIn() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen()));
  }

  bool inFinalPage() {
    if (_currentPage == _numPages - 1) {
      return true;
    }
    return false;
  }

  _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double abovePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: safeAreaPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => _navigateToSignIn(),
                  child: Text(
                    "Skip",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColor.kPrimaryColor.shade400),
                  ),
                ),
              ],
            ),
          ),
          Container(
              // color: kBlack,
              padding: EdgeInsets.only(top: abovePadding),
              height: size.height * 0.73,
              width: size.width,
              child: PageView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  OnboardingAnimationOne(
                    size: size,
                  ),
                  OnboardingAnimationTwo(
                    size: size,
                  ),
                ],
              
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: IndicatorListWidget()
                .buildPageIndicator(_numPages, _currentPage),
          ),
         verticalSpaceLarge,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: SPFlatButton(
                pressState: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    return const LoginScreen();
                  }));
                },
                active: true,
                textColor: AppColor.kWhiteColor,
                text: "Get Started",
                buttonColor: AppColor.kGreyNeutral.shade900),
          ),
          verticalSpaceRegular
        ],
      ),
    );
  }
}


