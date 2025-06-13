  import 'dart:async';

import 'package:flutter/material.dart';
  import 'package:utilidades/src/controller/temperatura_controller.dart';

  class HomeView extends StatefulWidget {
    
    const HomeView({super.key});

    @override
    State<HomeView> createState() => _HomeViewState();
    
  }

  class _HomeViewState extends State<HomeView> {
    bool carregando = false;
    double? temperatura;
    final controller = TemperaturaController();
 /*    final _streamController = StreamController();

    Stream<double> iniciarAtualizacaoTemperatura(){
      Timer.periodic(Duration(seconds: 2), (_) {
        double novaTemp = ...;
        _streamController.add(novaTemp);
      }
      );
      return _streamController.stream;
    } */
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(carregando)
                CircularProgressIndicator()
              else if (temperatura != null)
                Text(
                  'Temperatura: ${temperatura!.toStringAsFixed(1)} C',
                  style: TextStyle(fontSize: 32),
                )
                else 
                  Text(
                    'Clique no botão para ver a temperatura',
                    style: TextStyle(fontSize: 18),
                  ),              
              ElevatedButton(onPressed: () async {
                setState(() {
                  carregando = true;
                  
                });
                double temp = await controller.carregarTemperaturaInicial();
                
                setState(() {
                  carregando = false;
                  temperatura = temp;
                });
              }, child: Text("Ver temperatura")),
            ],
          ),
        ),
      );
    }
  } 