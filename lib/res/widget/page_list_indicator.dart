import 'package:flutter/widgets.dart';
import 'package:smartpay/constants/constant.dart';

class IndicatorListWidget {
  IndicatorListWidget();

  List<Widget> buildPageIndicator(int carouselNo, int currentPage) {
    List<Widget> list = [];
    for (int i = 0; i < carouselNo; i++) {
      list.add(i == currentPage
          ?  Indicator(isActive: true, colorActive: AppColor.kGreyNeutral.shade900)
          :  Indicator(isActive: false, colorNotActive: AppColor.kGreyNeutral.shade300));
    }
    return list;
  }
}

class Indicator extends StatelessWidget {
  const Indicator(
      {required this.isActive, this.colorActive, this.colorNotActive, Key? key})
      : super(key: key);

  final bool isActive;
  final Color? colorActive;
  final Color? colorNotActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kDuration,
      curve: kCurve,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 7.0,
      width: isActive ? 34.0 : 8.0,
      decoration: BoxDecoration(
          color: isActive ? colorActive : colorNotActive,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                color: AppColor.kPrimaryColor.withOpacity(0.25),
                blurRadius: 20)
          ]),
    );
  }
}
