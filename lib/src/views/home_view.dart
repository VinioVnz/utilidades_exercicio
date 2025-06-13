import 'package:flutter/material.dart';
import 'package:utilidades/src/controller/temperatura_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TemperaturaController();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Temperatura Atual em Cogulândia"),
            ElevatedButton(onPressed: (){}, child: Text("Ver temperatura")),
          ],
        ),
      ),
    );
  }
} 