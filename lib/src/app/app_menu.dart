import 'package:flutter/material.dart';
import 'package:utilidades/src/models/menu_model.dart';
import 'package:utilidades/src/views/home_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Home',
    icon: Icons.home, 
    route: '/home', 
    page: HomeView()),
];
