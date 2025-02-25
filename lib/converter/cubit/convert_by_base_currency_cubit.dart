import 'package:bloc/bloc.dart';
import 'package:curreny_converter/converter/model/new_latest_rate_model.dart';
import 'package:curreny_converter/converter/service/get_latest_rates_service.dart';
import 'package:curreny_converter/model/result.dart';

class ConvertByBaseCurrencyCubit extends Cubit<Result<NewLatestRateModel>> {
  final GetLatestRatesService _ratesService;
  ConvertByBaseCurrencyCubit(this._ratesService) : super(Result(isLoading: true));

  Future<void> getRateBaseList({String? base_currency}) async{
    try {
      emit(Result(isLoading: true));
      final rateList = await _ratesService.getRatesByBase(baseCurrency: base_currency);
      emit(Result(data: rateList));
    } catch (e) {
      emit(Result(error: e.toString()));
      rethrow;
    }
  }
}
