import 'dart:math';

class TemperaturaController {
  Future<double> carregarTemperaturaInicial() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 25 + Random().nextDouble() * 5,
    );
  }
}
