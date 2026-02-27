import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final int? id;

  const DetailsPage({super.key, this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do documento')),
      body: const Center(
        child: Text(
          'Aqui serão exibidos os detalhes do documento selecionado.',
        ),
      ),
    );
  }
}
