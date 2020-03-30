import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter_example/counter_screen/CounterScreenBloc.dart';

class CounterScreen extends StatefulWidget {
  CounterScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  CounterScreenBloc _counterScreenBloc;

  @override
  void dispose() {
    /// Closing the bloc in dispose to avoid memory leaks
    _counterScreenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialize bloc in the build method
    _counterScreenBloc = BlocProvider.of<CounterScreenBloc>(context);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<CounterScreenBloc, CounterScreenState>(
        builder: (context, state) {
      print("HIT IT");

      if (state is ShowLoadingCounterScreen) {
        print("triggered state");

        /// Show Loading Screen
        return buildLoadingScreen();
      } else if (state is ShowCounterValue) {
        print("SHOW COUNTER VALUE");

        /// Show Counter Value
        return buildCounterScreen(state.counterValue);
      } else {
        print("ELSE");

        /// Just returning an empty container
        return Container();
      }
    });
  }

  Widget buildCounterScreen(int counterValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You have pushed the button this many times:',
        ),
        Text(
          counterValue.toString(),
          style: Theme.of(context).textTheme.display1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              SizedBox(
                width: 50,
              ),
              FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(
                width: 50,
              ),
              FloatingActionButton(
                onPressed: _randomCounter,
                tooltip: 'Random',
                child: Icon(Icons.shuffle),
              )
            ],
          ),
        )
      ],
    );
  }

  void _incrementCounter() {
    _counterScreenBloc.add(IncrementCounterValue());
  }

  void _randomCounter() {
    _counterScreenBloc.add(GenerateRandomCounterValue());
  }

  void _decrementCounter() {
    _counterScreenBloc.add(DecrementCounterValue());
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Counter Bloc Example"),
    );
  }

  Widget buildLoadingScreen() {
    return Center(child: CircularProgressIndicator());
  }
}
