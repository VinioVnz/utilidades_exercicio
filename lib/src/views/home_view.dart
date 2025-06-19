import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:utilidades/src/controller/temperatura_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Stream<double>? streamTemperatura;
  List<double> ultimasTemperaturas = [];
  bool carregando = false;
  double? temperatura;
  double? resultadoIsolate;

  final controller = TemperaturaController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (carregando)
              CircularProgressIndicator()
            else if (streamTemperatura != null)
              StreamBuilder<double>(
                stream: streamTemperatura,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double tempAtual = snapshot.data!;

                    ultimasTemperaturas.add(tempAtual);
                    if (ultimasTemperaturas.length > 10) {
                      ultimasTemperaturas.removeAt(0);
                    }

                    return Column(
                      children: [
                        Icon(
                          tempAtual >= 27 ? Icons.wb_sunny : Icons.cloud,
                          size: 48,
                          color: tempAtual >= 27 ? Colors.orange : Colors.blueGrey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Temp: ${tempAtual.toStringAsFixed(1)} °C',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    );
                  } else {
                    return Text("Aguardando temperatura...");
                  }
                },
              )
            else
              Text(
                'Clique no botão para ver a temperatura',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                setState(() => carregando = true);
                double temp = await controller.carregarTemperaturaInicial();
                setState(() {
                  carregando = false;
                  temperatura = temp;
                  streamTemperatura = controller
                      .iniciarAtualizacaoTemperatura();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff46749),
                foregroundColor: Colors.white,
              ),
              child: Text("Ver temperatura"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (ultimasTemperaturas.length < 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "São necessários 10 valores para calcular a média.",
                      ),
                    ),
                  );
                  return;
                }

                double media = await compute(
                  calcularMedia,
                  List<double>.from(ultimasTemperaturas),
                );
                setState(() {
                  resultadoIsolate = media;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff46749),
                foregroundColor: Colors.white,
              ),
              child: Text("Calcular média (Isolate)"),
            ),
            if (resultadoIsolate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Média das últimas 10 temperaturas: ${resultadoIsolate!.toStringAsFixed(1)} °C',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Função que roda em Isolate
double calcularMedia(List<double> temperaturas) {
  double soma = temperaturas.reduce((a, b) => a + b);
  return soma / temperaturas.length;
}
