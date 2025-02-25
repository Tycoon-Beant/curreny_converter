import 'package:bloc/bloc.dart';
import 'package:curreny_converter/converter/model/new_latest_rate_model.dart';
import 'package:curreny_converter/converter/service/get_latest_rates_service.dart';
import 'package:curreny_converter/model/result.dart';



class RateListCubit extends Cubit<Result<NewLatestRateMOdel>> {
  final GetLatestRatesService _ratesService;
  RateListCubit(this._ratesService) : super(Result(isLoading: true)){
    getRateList();
  }


  Future<void> getRateList() async{
    try {
      emit(Result(isLoading: true));
      final rateList = await _ratesService.getRates();
      emit(Result(data: rateList));
    } catch (e) {
      emit(Result(error: e.toString()));
      rethrow;
    }
  }
}
