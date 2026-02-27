import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_events.dart';
import 'package:horas_compl_app/features/presentation/pages/hours_page.dart';
import 'package:horas_compl_app/features/presentation/pages/documents_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final pages = [HoursPage(), DocumentsPage()];

  final titles = const ['Minhas horas', 'Meus documentos'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex])),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.access_time),
              iconColor: Theme.of(context).colorScheme.surface,
              title: Text('Minhas horas'),
              textColor: Theme.of(context).colorScheme.surface,
              onTap: () {
                context.read<DocumentsBloc>().add(LoadDocumentsEvent());

                setState(() => selectedIndex = 0);

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet_outlined),
              iconColor: Theme.of(context).colorScheme.surface,
              title: Text('Meus documentos'),
              textColor: Theme.of(context).colorScheme.surface,
              onTap: () {
                context.read<DocumentsBloc>();

                setState(() => selectedIndex = 1);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
