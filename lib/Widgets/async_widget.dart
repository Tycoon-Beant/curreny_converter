import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/result.dart';

class AsyncWidget<C extends StateStreamable<Result<E>>, E>
    extends StatelessWidget {
  final Widget Function(E? data) data;
  const AsyncWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, Result<E>>(builder: (context, state) {
      if (state.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.error != null) {
        return Center(child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(state.error.toString(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
        ));
      }
      else {
        return data(state.data);
      }
    });
  }
}
