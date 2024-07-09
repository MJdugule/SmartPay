class CountryCode {
  CountryCode(
      {required this.countryDialCode,
      required this.countryIsoCode,
      required this.countryName,
      required this.countryFlag,
      required this.countryMinLength,
      required this.countryMaxLength,
      required this.currencyCode,
      required this.currencyName,
      required this.currencySymbol});

  String countryDialCode;
  String countryIsoCode;
  String countryName;
  String countryFlag;
  int countryMinLength;
  int countryMaxLength;
  String currencyCode;
  String currencyName;
  String currencySymbol;

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        countryDialCode: json["dial_code"],
        countryIsoCode: json["code"],
        countryName: json["name"],
        countryFlag: json["flag"],
        countryMinLength: json["min_length"],
        countryMaxLength: json["max_length"],
        currencyCode: json["currency_code"],
        currencyName: json["currency_name"],
        currencySymbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "dial_code": countryDialCode,
        "code": countryIsoCode,
        "name": countryName,
        "flag": countryFlag,
        "min_length": countryMinLength,
        "max_length": countryMaxLength,
        "currency_code": currencyCode,
        "currency_name": currencyName,
        "symbol": currencySymbol
      };
}
