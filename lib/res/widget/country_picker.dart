import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/models/country_code.dart';
import 'package:smartpay/repositories/country_repository.dart';
import 'package:smartpay/res/widget/search_box.dart';
import 'package:smartpay/styles/app_theme.dart';
import 'package:smartpay/utilities/bottom_sheet_utils.dart';

class SPCountryDropDown extends StatelessWidget {
  const SPCountryDropDown(
      {Key? key,
      required this.onChanged,
      required this.countryName,
      required this.countryFlag,
      this.currentValue})
      : super(key: key);

  final ValueChanged<CountryCode> onChanged;

  final String countryName;
  final String countryFlag;
  final CountryCode? currentValue;

  String _countryName(CountryCode? value) {
    if (value == null) return countryName;
    return value.countryName;
  }

  String _countryFlag(CountryCode? value) {
    if (value == null) return countryFlag;
    return value.countryFlag;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<CountryCode>(
        initialValue: currentValue,
        builder: (formFieldState) {
          late InputBorder shape;
          if (formFieldState.hasError) {
            shape = Theme.of(context).inputDecorationTheme.errorBorder!;
          } else {
            shape = Theme.of(context).inputDecorationTheme.enabledBorder!;
          }
          return ListTile(
            onTap: () async {
              final countryCode = await BottomSheetUtilities()
                  .showCountryCodeModalSheet(context, false);
              if (countryCode != null) {
                formFieldState.didChange(countryCode);
                onChanged(countryCode);
              }
            },
            leading: Text(
              _countryFlag(formFieldState.value),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 28),
            ),
            title: Text(
              _countryName(formFieldState.value),
              style: formFieldState.value == null
                  ? kRegularTextStyle
                  : kLargeTextStyle.copyWith(fontSize: 16),
            ),
            trailing: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.kGreyNeutral.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FontAwesomeIcons.chevronDown,
                  color: kDarkGrey,
                  size: 14,
                )),
            tileColor: AppColor.kGreyNeutral.shade100,
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            horizontalTitleGap: 10,
            minLeadingWidth: 0,
            shape: shape,
          );
        });
  }
}

class SPCountryCodePicker extends StatefulWidget {
  const SPCountryCodePicker({Key? key, required this.isCountryPicker})
      : super(key: key);
  final bool isCountryPicker;

  @override
  State<SPCountryCodePicker> createState() => _SPCountryCodePickerState();
}

class _SPCountryCodePickerState extends State<SPCountryCodePicker> {
  List<CountryCode> countryCodes = CountryRepository().getCountryCode();
  final TextEditingController _searchQuery = TextEditingController();
  bool isSearching = false;
  List<CountryCode> filteredList = [];
  List<CountryCode> emptyList = [];
  String searchText = "";

  List<CountryCode> _buildSearchList() {
    if (filteredList.isEmpty) {
      return filteredList = countryCodes;
    } else {
      filteredList = countryCodes
          .where((userCountry) => userCountry.countryName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
      return filteredList;
    }
  }

  @override
  void initState() {
    filteredList = countryCodes;
    super.initState();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SPSearchBox(
                  hintText: 'Search country',
                  textEditingController: _searchQuery,
                  onChanged: (value) {
                    _searchQuery.addListener(() {
                      if (_searchQuery.text.isEmpty) {
                        if (mounted) {
                          setState(() {
                            isSearching = false;
                            searchText = "";
                            _buildSearchList();
                          });
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            isSearching = true;
                            searchText = _searchQuery.text;
                            _buildSearchList();
                          });
                        }
                      }
                    });
                  },
                  clearField: () {
                    _searchQuery.clear();
                    setState(() {});
                  },
                ),
              ),
          
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text("Cancel", style: kLargeTextStyle.copyWith(fontSize: 16),),
                ),)
            ],
          ),
          Expanded(
              child: filteredList.isEmpty
                  ? const Center(child: Text('No search data to display'))
                  : ListView.separated(
                      padding: AppTheme().kListPadding,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                            
                            leading: Text(filteredList[index].countryFlag,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 30)),
                            title: Row(
                              children: [
                                horizontalSpaceTiny,
                                Text(
                                  filteredList[index].countryIsoCode,
                                  style: kRegularTextStyle.copyWith(fontSize: 17, )
                                ),
                                horizontalSpaceRegular,
                                Expanded(
                                  child: Text(
                                    filteredList[index].countryName,
                                    style: kLargeTextStyle.copyWith(fontSize: 17)
                                  ),
                                ),
                              ],
                            ),
                            trailing: widget.isCountryPicker == true
                                ? Text(
                                    filteredList[index].countryDialCode,
                                    style: kRegularTextStyle.copyWith(fontSize: 10)
                                  )
                                : null,
                            onTap: () =>
                                Navigator.pop(context, filteredList[index]),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            horizontalTitleGap: 8,
                            minLeadingWidth: 0,
                          ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(),
                      itemCount: filteredList.length))
        ],
      ),
    );
  }
}
