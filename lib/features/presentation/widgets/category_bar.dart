import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final String title;
  final int current;
  final int total;

  const CategoryBar({
    super.key,
    required this.title,
    required this.current,
    required this.total,
  });

  double get progress => current / total;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Text(
                '$current/$total',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                // espessura da borda
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black, // cor da borda
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),

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
            ),
          ],
        ),
      ),
    );
  }
}
