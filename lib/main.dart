import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter_example/counter_screen/CounterScreenBloc.dart';

import 'counter_screen/CounterScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildCounterScreen(),
    );
  }

  Widget _buildCounterScreen() => BlocProvider<CounterScreenBloc>(
      create: (context) => CounterScreenBloc(), child: CounterScreen());
}
