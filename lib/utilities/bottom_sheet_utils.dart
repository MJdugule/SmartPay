import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/country_picker.dart';

class BottomSheetUtilities {
  BottomSheetUtilities();

  showCountryCodeModalSheet(BuildContext context, bool isCountry) {
    //Navigator.pop(context);
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        context: context,
        builder: (context) {
          return BackdropFilter(
             filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Material(
              color: AppColor.kWhiteColor,
              borderRadius: BorderRadius.circular(20),
              child: DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.75,
                  minChildSize: 0.5,
                  maxChildSize: 0.8,
                  builder:
                      (BuildContext context, ScrollController scrollController) {
                    return SPCountryCodePicker(isCountryPicker: isCountry);
                  }),
            ),
          );
        });
  }
}
