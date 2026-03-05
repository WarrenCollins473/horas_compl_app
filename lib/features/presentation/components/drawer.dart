import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/app_routes.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_events.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  void _navigate(BuildContext context, String route) {
    if (currentRoute == route) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.access_time),
            iconColor: Theme.of(context).colorScheme.surface,
            title: Text('Minhas horas'),
            textColor: Theme.of(context).colorScheme.surface,
            onTap: () {
              context.read<DocumentsBloc>();
              _navigate(context, AppRoutes.hours.path);
            },
          ),
          ListTile(
            leading: const Icon(Icons.text_snippet_outlined),
            iconColor: Theme.of(context).colorScheme.surface,
            title: Text('Meus documentos'),
            textColor: Theme.of(context).colorScheme.surface,
            onTap: () {
              context.read<DocumentsBloc>();
              _navigate(context, AppRoutes.documents.path);
            },
          ),
        ],
      ),
    );
  }
}
