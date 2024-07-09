import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/models/onboarding.dart';
import 'package:smartpay/res/widget/animation_widget.dart';

class OnboardingAnimationOne extends StatefulWidget {
  const OnboardingAnimationOne({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<OnboardingAnimationOne> createState() => _OnboardingAnimationOneState();
}

class _OnboardingAnimationOneState extends State<OnboardingAnimationOne>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> animationTwo;
  List<Onboarding> onBoardingList = Onboarding.list;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 9),
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1);
    animation = fadeSlideTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.fastLinearToSlowEaseIn),
      reverseCurve: const Interval(0.5, 0.0, curve: Curves.bounceOut),
    ));

    animationTwo = fadeSlideTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.1, 0.2, curve: Curves.bounceInOut),
      // reverseCurve: const Interval(0.5, 0.0, curve: Curves.bounceIn),
    ));

    controller.repeat();

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Positioned(
          top: -80,
          right: 0,
          left: 0,
          child: FadeSlideTransition(
              additionalOffset: 0.0,
              animation: animation,
              child: Image.asset(
                kOnboardingDevice1,
                scale: .9,
              )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            // height: size.height / 3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  // AppColor.kWhiteColor,
                  AppColor.kWhiteColor,
                  AppColor.kWhiteColor,
                  AppColor.kWhiteColor.withOpacity(.02),
                ])
                // color: AppColor.kPrimaryColor
                ),
            child: Padding(
              padding: safeAreaPadding.copyWith(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: widget.size.height * 0.15),
                  Text(onBoardingList[0].title,
                      textAlign: TextAlign.center,
                      style: kLargeTextStyle.copyWith(fontSize: 24)),
                  SizedBox(height: widget.size.height * 0.02),
                  Container(
                    margin: const EdgeInsets.only(
                        left: kPaddingMM, right: kPaddingMM),
                    child: Text(onBoardingList[0].description,
                        textAlign: TextAlign.center,
                        style: kRegularTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.kGreyNeutral.shade400)),
                  ),
                  verticalSpaceRegular
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 20,
          left: 20,
          child: FadeSlideTransition(
              additionalOffset: 0.0,
              animation: animationTwo,
              child: Image.asset(kOnboardingpop)),
        ),
      ],
    );
  }
}

class OnboardingAnimationTwo extends StatefulWidget {
  const OnboardingAnimationTwo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<OnboardingAnimationTwo> createState() => _OnboardingAnimationTwoState();
}

class _OnboardingAnimationTwoState extends State<OnboardingAnimationTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller, controller2;
  late Animation<double> animation;
  late Animation<Offset> animationTwo, animationThree;
  List<Onboarding> onBoardingList = Onboarding.list;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 9),
    );
    // controller2 = AnimationController(
    //   vsync: this, // the SingleTickerProviderStateMixin
    //   duration: const Duration(seconds: 2),
    // );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1);
    animation = fadeSlideTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.fastLinearToSlowEaseIn),
      reverseCurve: const Interval(0.5, 0.0, curve: Curves.bounceOut),
    ));

    animationTwo = Tween<Offset>(
      begin: const Offset(0.9, 0.0),
      end: const Offset(0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.fastLinearToSlowEaseIn),
    ));

    animationThree = Tween<Offset>(
      begin: const Offset(-.95, 0.0),
      end: const Offset(-.2, 0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.fastLinearToSlowEaseIn),
    ));

    controller.repeat();

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Positioned(
          top: -80,
          right: 0,
          left: 0,
          child: FadeSlideTransition(
              additionalOffset: 0.0,
              animation: animation,
              child: Image.asset(
                kOnboardingDevice2,
                scale: .9,
              )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            // height: size.height / 3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  // AppColor.kWhiteColor,
                  AppColor.kWhiteColor,
                  AppColor.kWhiteColor,
                  AppColor.kWhiteColor.withOpacity(.02),
                ])
                // color: AppColor.kPrimaryColor
                ),
            child: Padding(
              padding: safeAreaPadding.copyWith(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: widget.size.height * 0.15),
                  Text(onBoardingList[1].title,
                      textAlign: TextAlign.center,
                      style: kLargeTextStyle.copyWith(fontSize: 24)),
                  SizedBox(height: widget.size.height * 0.02),
                  Container(
                    margin: const EdgeInsets.only(
                        left: kPaddingMM, right: kPaddingMM),
                    child: Text(onBoardingList[1].description,
                        textAlign: TextAlign.center,
                        style: kRegularTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.kGreyNeutral.shade400)),
                  ),
                  verticalSpaceRegular
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 110,
          right: 20,
          left: 20,
          child: SlideTransition(
              position: animationTwo,
              child: Image.asset(
                kContactSlide,
                scale: 1.5,
              )),
        ),
        Positioned(
          top: 110,
          right: 20,
          left: 20,
          child: SlideTransition(
              position: animationThree,
              child: Image.asset(
                kPaymentSlide,
                scale: 1.3,
              )),
        ),
      ],
    );
  }
}
