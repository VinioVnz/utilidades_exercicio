import 'package:flutter/material.dart';
import 'package:utilidades/src/widgets/custom_app_bar.dart';
import 'package:utilidades/src/widgets/custom_app_drawer.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget body;
  const BaseLayout({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      drawer: CustomAppDrawer(),
      body: body,
    );
  }
}