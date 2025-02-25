// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewLatestRateModel {
  List<Data>? data;
  List<Data>? selectedCurrencies;
  NewLatestRateModel({this.data, this.selectedCurrencies});

  NewLatestRateModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> currencyMap = json['data'];
    List<String> selectedCurrencyCodes = [
      "USD",
      "INR",
      "PKR",
      "EUR",
      "GBP",
      "AUD",
      "CAD",
      "JPY",
      "NZD",
      "CHF",
      "HKD"
    ];
    data = currencyMap.entries.map((entry) {
      return Data(unit: entry.key, rate: entry.value);
    }).toList();
    selectedCurrencies = data
        ?.where((currency) => selectedCurrencyCodes.contains(currency.unit))
        .toList();
  
  }
}

class Data {
  String? unit;
  num? rate;
  Data({
    this.unit,
    this.rate,
  });
  Data.fromJson(Map<String , dynamic> json) {
    unit: json["unit"];
    rate : json["rate"];
  }
}
