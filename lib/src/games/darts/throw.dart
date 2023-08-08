part of './darts_game.dart';

class Throw {
  final int _number;
  final Modifier _modifier;

  Throw({
    required int number,
    Modifier modifier = Modifier.signle,
  })  : _number = number,
        _modifier = modifier;

  int get number => _number;
  Modifier get modifier => _modifier;
  int get score => _number * _modifier.value;

  @override
  String toString() {
    final modifier = _modifier == Modifier.triple
        ? 'T'
        : _modifier == Modifier.double
            ? 'D'
            : '';

    return '$modifier$_number';
  }
}

enum Modifier {
  signle(1),
  double(2),
  triple(3);

  const Modifier(this.value);
  final int value;
}
