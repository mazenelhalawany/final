import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/core/widget/app_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(context),
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: const Text("MainPage"),
        ),
        body: const Scaffold(body: Center(child: Text("Welcome "))));
  }
}
