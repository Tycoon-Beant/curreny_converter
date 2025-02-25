// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewLatestRateMOdel {
  List? data;

  NewLatestRateMOdel({this.data});

  NewLatestRateMOdel.fromJson(Map<String, dynamic> json) {
    data = json['data'].entries.map((entry) {
      return Data(unit: entry.key, rate: entry.value.toString());
    }).toList();
  }


}

class Data {
  String? unit;
  String? rate;
  Data({
    this.unit,
    this.rate,
  });
}
