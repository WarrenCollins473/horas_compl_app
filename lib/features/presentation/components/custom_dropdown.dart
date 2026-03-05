import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final List<DropdownMenuEntry<String>> entries;
  final bool enabled;
  final void Function(String?)? onSelected;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.entries,
    this.controller,
    this.enabled = true,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      hintText: hintText,
      controller: controller,
      enabled: enabled,
      expandedInsets: EdgeInsets.zero,
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
      dropdownMenuEntries: entries,
      onSelected: onSelected,
    );
  }
}
