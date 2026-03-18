import 'package:flutter/material.dart';

class HoursInput extends StatefulWidget {
  final int individualHours;
  final int maximumHours;
  final int obtainedHours;
  final Function(int hoursObtained) onHoursCalculated;

  const HoursInput({
    super.key,
    required this.individualHours,
    required this.maximumHours,
    required this.onHoursCalculated,
    required this.obtainedHours,
  });

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  final TextEditingController _hoursController = TextEditingController();

  void _calculateHours(String value) {
    final entered = int.tryParse(value) ?? 0;

    int result = 0;

    // evita divisão por zero
    if (widget.individualHours <= 0) {
      widget.onHoursCalculated(0);
      return;
    }

    if (entered >= widget.individualHours) {
      result =
          ((entered / widget.individualHours).floor() * widget.individualHours);

      if (result > widget.maximumHours) {
        result = widget.maximumHours;
      }
    }

    widget.onHoursCalculated(result);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Horas lançadas',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _hoursController,
                keyboardType: TextInputType.number,
                onChanged: _calculateHours,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Horas obtidas',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              widget.obtainedHours.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
