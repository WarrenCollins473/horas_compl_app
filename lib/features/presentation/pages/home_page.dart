import 'package:flutter/material.dart';
import 'package:horas_compl_app/features/presentation/widgets/category_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryBar(current: 45, title: 'Ensino', total: 100),
            CategoryBar(current: 45, title: 'Ensino', total: 100),
            CategoryBar(current: 45, title: 'Ensino', total: 100),
            CategoryBar(current: 45, title: 'Ensino', total: 100),
          ],
        ),
      ),
    );
  }
}
