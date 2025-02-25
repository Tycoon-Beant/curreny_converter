import 'package:curreny_converter/Widgets/async_widget.dart';
import 'package:curreny_converter/converter/config/common.dart';
import 'package:curreny_converter/converter/cubit/convert_by_base_currency_cubit.dart';
import 'package:curreny_converter/converter/cubit/rate_list_cubit.dart';
import 'package:curreny_converter/converter/model/new_latest_rate_model.dart';
import 'package:curreny_converter/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final formKey = GlobalKey<FormState>();
  final amountKey = GlobalKey<FormFieldState>();
  TextEditingController amountController = TextEditingController();

  String? fromCurrency;
  String? toCurrency;

  String result = "";
  bool showResults = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RateListCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => ConvertByBaseCurrencyCubit(context.read()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xffA1E3F9), Color(0xffD1F8EF)])),
              // color: Colors.blue.shade100.withOpacity(0.2),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: AsyncWidget<RateListCubit, NewLatestRateModel>(
                  data: (rates) {
                    // final listdata = rates?.ratesList ?? [];

                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Text("Currency Converter",
                                style: context.theme.headlineSmall!
                                    .copyWith(color: Color(0xff1F2261))),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "Check live rates, set rate alerts, receive notifications and more.",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: amountController,
                              key: amountKey,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: "enter amount",
                                  hintStyle: context.theme.titleMedium!
                                      .copyWith(color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "From: ",
                                style: context.theme.titleMedium,
                              ),
                              const SizedBox(width: 20),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      hint: Text("from"),
                                      value: fromCurrency,
                                      items: rates!.data?.map((rate) {
                                        return DropdownMenuItem<String>(
                                          value: rate.unit,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width: 100,
                                                  child: Text("${rate.unit} ")),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          fromCurrency = value;
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "To: ",
                                style: context.theme.titleMedium,
                              ),
                              const SizedBox(width: 40),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      hint: Text("to"),
                                      value: toCurrency,
                                      items: rates.data?.map((rate) {
                                        return DropdownMenuItem<String>(
                                          value: rate.unit,
                                          child: SizedBox(
                                              width: 100,
                                              child: Text("${rate.unit} ")),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          toCurrency = value;
                                        });
                                  //       context
                                  // .read<ConvertByBaseCurrencyCubit>()
                                  // .getRateBaseList(base_currency: fromCurrency);
                                      }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              context
                                  .read<ConvertByBaseCurrencyCubit>()
                                  .getRateBaseList(base_currency: fromCurrency);
                                  setState(() {
                                    showResults = true;
                                  });
                              
                            },
                            child: Text(
                              "Convert",
                              style: context.theme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if(fromCurrency != null && toCurrency != null && showResults == true)
                          BlocBuilder<ConvertByBaseCurrencyCubit,
                              Result<NewLatestRateModel>>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "Converted Amount: \n ${toCurrency} ${state.data?.data!.singleWhere((e) => e.unit == toCurrency).rate?.toStringAsFixed(2) ?? 0} ",
                                      style: context.theme.titleMedium!
                                          .copyWith(color: Colors.blueAccent),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 180,
                                    child: Builder(builder: (context) {
                                      var filteredCurrencies = rates
                                          .selectedCurrencies!
                                          .where((currency) =>
                                              currency.unit != fromCurrency &&
                                              currency.unit != toCurrency)
                                          .toList();
                                      return GridView.builder(
                                        padding: EdgeInsets.only(left: 70),
                                        itemCount: rates.selectedCurrencies!
                                                .where((currency) =>
                                                    currency.unit !=
                                                    fromCurrency)
                                                .length -
                                            1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var currency =
                                              filteredCurrencies[index];
                                          return Text(
                                            "${currency.unit} - ${currency.rate?.toStringAsFixed(2)}",
                                            style: context.theme.titleMedium!
                                                .copyWith(
                                                    color: Colors.blueGrey),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 0,
                                                childAspectRatio: 5),
                                      );
                                    }),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // String calculate(
  //     NewLatestRateModel? rates, String? amount, String? toCurrency) {
  //   num fromRate = num.tryParse(rates?.data
  //               ?.firstWhere((rateData) => rateData.unit == fromCurrency,
  //                   orElse: () => Data(unit: "N/A", rate: "1"))
  //               .rate ??
  //           "1.0") ??
  //       1.0;

  //   num toRate = num.tryParse(rates?.data
  //               ?.firstWhere((rate) => rate.unit == toCurrency,
  //                   orElse: () => Data(unit: "N/A", rate: "1.0"))
  //               .rate ??
  //           "1.0") ??
  //       1.0;

  //   num? numenator = int.tryParse(amount ?? "0") ?? 0;
  //   num result = (numenator / fromRate) * toRate;

  //   return result.toStringAsFixed(2); // Round to 2 decimal places
  // }
}
