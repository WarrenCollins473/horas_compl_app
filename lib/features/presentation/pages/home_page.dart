import 'package:flutter/material.dart';
import 'package:horas_compl_app/features/presentation/widgets/category_bar.dart';
import 'package:horas_compl_app/features/presentation/widgets/total_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TotalBar(current: 150, title: 'Total de Horas', total: 300),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width / 1.3,
              height: 1,
              color: Colors.grey[850],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Por categoria',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const CategoryBar(current: 45, title: 'Ensino', total: 100),
                const CategoryBar(current: 45, title: 'Ensino', total: 100),
                const CategoryBar(current: 45, title: 'Ensino', total: 100),
                const CategoryBar(current: 45, title: 'Ensino', total: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
