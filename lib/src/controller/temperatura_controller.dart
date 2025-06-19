import 'dart:async';
import 'dart:math';

class TemperaturaController {
  final _streamController = StreamController<double>();
  Timer? _timer;

  Future<double> carregarTemperaturaInicial() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 25 + Random().nextDouble() * 5,
    );
  }

  Stream<double> iniciarAtualizacaoTemperatura() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      double novaTemp = 25 + Random().nextDouble() * 5;
      _streamController.add(novaTemp);
    });
    return _streamController.stream;
  }

  void dispose() {
    _timer?.cancel();
    _streamController.close();
  }
}
