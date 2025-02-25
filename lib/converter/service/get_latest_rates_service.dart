

import 'package:curreny_converter/converter/model/new_latest_rate_model.dart';
import 'package:curreny_converter/dio_instance.dart';

class GetLatestRatesService {


  GetLatestRatesService();

Future<NewLatestRateMOdel> getRates() async{
  try {
    final response =  await DioSingleton.instance.dio.get("https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_6hHFRmS2cwxbEu6FUS4J4FTnQ8L07qtHLGNA9JwU");
    final body = response.data;
    return NewLatestRateMOdel.fromJson(body);
  } catch (e) {
    print("Error getting rates Lsit: $e");
    rethrow;
  }
}

}