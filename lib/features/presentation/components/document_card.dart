import 'package:flutter/material.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

class DocumentCard extends StatelessWidget {
  final DocumentsEntity document;
  final VoidCallback onTap;

  const DocumentCard({super.key, required this.document, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,

      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.black, width: 1),
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Categoria',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(document.category, style: const TextStyle(fontSize: 12)),
                const Text(
                  'Atividade',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(document.activity, style: const TextStyle(fontSize: 12)),
                const Text(
                  'Tipo',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(document.type, style: const TextStyle(fontSize: 12)),
                const Text(
                  'horas',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  document.hours.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
