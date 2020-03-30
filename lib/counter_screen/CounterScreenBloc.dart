import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_counter_example/counter_screen/CounterRepo.dart';

/// Events

class CounterScreenEvent {}

class IncrementCounterValue extends CounterScreenEvent {}

class DecrementCounterValue extends CounterScreenEvent {}

class GenerateRandomCounterValue extends CounterScreenEvent {}

/// States

class CounterScreenState extends Equatable {
  @override
  List<Object> get props => null;
}

class ShowLoadingCounterScreen extends CounterScreenState {}

class ShowCounterValue extends CounterScreenState {
  @override
  List<Object> get props => [counterValue];

  final int counterValue;

  ShowCounterValue(this.counterValue);
}

/// BLoC
class CounterScreenBloc extends Bloc<CounterScreenEvent, CounterScreenState> {
  int counterValue = 0;

  @override
  CounterScreenState get initialState => ShowCounterValue(counterValue);

  @override
  Stream<CounterScreenState> mapEventToState(CounterScreenEvent event) async* {
    if (event is IncrementCounterValue) {
      this.counterValue++;
      yield ShowCounterValue(counterValue);
    }

    if (event is DecrementCounterValue) {
      this.counterValue--;
      yield ShowCounterValue(counterValue);
    }

    if (event is GenerateRandomCounterValue) {
      /// Showing Loading Screen
      yield ShowLoadingCounterScreen();

      /// Created a repository called CounterRepo
      /// which is responsible for getting data
      counterValue = await CounterRepo().getRandomValue();

      /// Showing the random number
      yield ShowCounterValue(counterValue);
    }
  }
}
