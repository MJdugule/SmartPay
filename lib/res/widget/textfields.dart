import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartpay/constants/constant.dart';

class SPPasswordField extends StatefulWidget {
  final bool? obscureText;
  final String? hintText, helperText, errorText;
//FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const SPPasswordField(
      {this.obscureText,
      this.hintText,
      this.helperText,
      this.onChanged,
      this.errorText,
      this.controller,
      this.textInputAction,
      Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BPPasswordField createState() => _BPPasswordField();
}

class _BPPasswordField extends State<SPPasswordField> {
  bool obscureText = true;
  final FocusNode _textFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      width: double.infinity,
      //height: kPaddingFF,
      child: TextFormField(
        cursorColor: AppColor.kPrimaryColor,
        focusNode: _textFieldFocus,
        obscureText: obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
                style: kFormHeaderTextStyle.copyWith(
          fontSize: 16,
        ),
        cursorHeight: 25,
        showCursor: true,

        decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: kRegularTextStyle,
           
            errorText: widget.errorText,
            errorStyle: kErrorTextStyle,
            filled: true,
            fillColor: AppColor.kGreyNeutral.shade100,
            suffixIcon:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                    size: 20,
                    color: kDeepGrey,
                  ),
                ),
              ],
            )),
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}

class SPTextField extends StatefulWidget {
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String? hintText, errorText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? isEnabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const SPTextField(
      {this.onChanged,
      required this.hintText,
      required this.errorText,
      required this.controller,
      this.validator,
      this.onSaved,
      this.textInputType,
      //this.focusNode,
      this.textInputAction,
      this.isEnabled,
      this.maxLength,
      this.inputFormatters,
      Key? key})
      : super(key: key);

  @override
  State<SPTextField> createState() => _SPTextFieldState();
}

class _SPTextFieldState extends State<SPTextField> {
  final FocusNode _textFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      inputFormatters: widget.inputFormatters,
      cursorColor: kMainColorDark,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      focusNode: _textFieldFocus,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      cursorHeight: 20,
      showCursor: true,
     
      style: kFormHeaderTextStyle.copyWith(fontSize: 16, ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        // labelText: widget.hintText,
        hintText: widget.hintText,
        hintStyle:kRegularTextStyle,
        errorStyle: kErrorTextStyle,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        // suffixIcon: widget.controller.text.isNotEmpty
        //     ? IconButton(
        //         onPressed: () {
        //           setState(() {
        //             widget.controller.clear();
        //           });
        //         },
        //         icon: Icon(
        //           FontAwesomeIcons.solidCircleXmark,
        //           size: 15,
        //           color: PrefUtils.getUserThemePreference() == true
        //               ? kLightGrey
        //               : kDarkGrey,
        //         ))
        // : const SizedBox(),
        filled: true,
        fillColor: AppColor.kGreyNeutral.shade100,
        errorText: widget.errorText,
      ),
    );
  }
}

class SPOtpInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autoFocus;
  final FocusNode focusNode;

  const SPOtpInputField(
      {required this.onChanged,
      required this.textEditingController,
      required this.focusNode,
      this.autoFocus = false,
      this.onFieldSubmitted,
      Key? key})
      : super(key: key);

  @override
  State<SPOtpInputField> createState() => _SPOtpInputFieldState();
}

class _SPOtpInputFieldState extends State<SPOtpInputField> {
  


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.fromLTRB(3, 10, 3, 10),
        child: Center(
          child: TextField(
            maxLength: 1,
            focusNode: widget.focusNode,
            autofocus: widget.autoFocus,
            readOnly: true,
            showCursor: true,
            cursorColor: AppColor.kPrimaryColor,
            // cursorHeight: 24,
            textAlign: TextAlign.center,
            style: kLargeTextStyle.copyWith(fontSize: 22),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
              focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              filled: true,
              fillColor: AppColor.kGreyNeutral.shade100,
              // alignLabelWithHint: true,
              // hintStyle: const TextStyle(fontSize: kFontS, color: kGrey),
              // hintText: '\u{25CB}',
              counterText: '',
            ),
            keyboardType: TextInputType.phone,
            onChanged: widget.onChanged,
            controller: widget.textEditingController,
            // obscureText: true,
            // onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}

class SPOtpInputFieldTwo extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autoFocus;
  final FocusNode focusNode;

  const SPOtpInputFieldTwo(
      {required this.onChanged,
      required this.textEditingController,
      required this.focusNode,
      this.autoFocus = false,
      this.onFieldSubmitted,
      Key? key})
      : super(key: key);

  @override
  State<SPOtpInputFieldTwo> createState() => _SPOtpInputFieldTwoState();
}

class _SPOtpInputFieldTwoState extends State<SPOtpInputFieldTwo> {
  


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 60,
        height: 50,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Center(
          child: TextField(
            maxLength: 1,
            focusNode: widget.focusNode,
            autofocus: widget.autoFocus,
            readOnly: true,
            showCursor: true,
            cursorColor: AppColor.kPrimaryColor,
            // cursorHeight: 24,
            textAlign: TextAlign.center,
            style: kLargeTextStyle.copyWith(fontSize: 29),
            decoration: InputDecoration(
              // contentPadding:
              //     const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.kPrimaryColor,
                  width: 2,
                  // style: BorderStyle.none,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                 borderSide: BorderSide(
                  color: AppColor.kPrimaryColor,
                  width: 2,
                  // style: BorderStyle.none,
                ),
              ),
              focusedBorder:  const UnderlineInputBorder(
                
                  // borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.kPrimaryColor,
                    width: 2,
                    // style: BorderStyle.none,
                  ),
                  ),
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              filled: true,
              fillColor: AppColor.kGreyNeutral.shade50,
             
              counterText: '',
            ),
            keyboardType: TextInputType.phone,
            onChanged: widget.onChanged,
            controller: widget.textEditingController,
            obscureText: true,
            // onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
