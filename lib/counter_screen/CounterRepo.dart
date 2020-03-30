import 'dart:math';

class CounterRepo {
  Future<int> getRandomValue() async {
    /// Returning a value after 2 seconds delay

    return Future.delayed(Duration(milliseconds: 2000))
        .then((onValue) => Random().nextInt(100));
  }
}
