import 'package:flutter/material.dart';

class TotalBar extends StatelessWidget {
  final String title;
  final int current;
  final int total;

  const TotalBar({
    super.key,
    required this.title,
    required this.current,
    required this.total,
  });

  double get progress => current / total;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text('Total de Horas', style: TextStyle(fontSize: 20)),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black, // cor da borda
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.hardEdge,

              child: TweenAnimationBuilder(
                curve: Curves.easeOut,
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(seconds: 1),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 16,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text('$current/$total', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
