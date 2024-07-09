import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/utilities/pref_utils.dart';

class SPSearchBox extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool? isEnabled;
  final String? hintText;
  final TextEditingController textEditingController;
  final VoidCallback clearField;

  const SPSearchBox(
      {this.onChanged,
      this.hintText,
      this.isEnabled,
      Key? key,
      required this.textEditingController,
      required this.clearField})
      : super(key: key);

  @override
  State<SPSearchBox> createState() => _SPSearchBoxState();
}

class _SPSearchBoxState extends State<SPSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kPaddingXL, right: kPaddingXL),
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.kGreyNeutral.shade100,
            
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  FontAwesomeIcons.searchengin,
                  color: kGrey,
                  size: kPaddingXL,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 35),
                child: TextField(
                  enabled: widget.isEnabled,
                  onChanged: widget.onChanged,
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: kGrey,
                    ),
                    hintText: widget.hintText,
                    suffixIcon: widget.textEditingController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => widget.clearField(),
                            icon: Icon(
                              FontAwesomeIcons.solidCircleXmark,
                              size: 15,
                              color: PrefUtils.getUserThemePreference() == true
                                  ? kLightGrey
                                  : kDarkGrey,
                            ))
                        : null,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          )),
    );
  }
}
