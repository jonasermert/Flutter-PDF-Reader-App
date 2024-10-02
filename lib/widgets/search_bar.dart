import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search PDFs...",
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }
}
