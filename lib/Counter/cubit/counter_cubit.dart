import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  static CounterCubit get(context) => BlocProvider.of<CounterCubit>(context);

  int counter = 1;

  void increment() {
    counter++;
    emit(CounterIncrementState());
  }

  void decrement() {
    counter--;
    emit(CounterDecrementtState());
  }
}
