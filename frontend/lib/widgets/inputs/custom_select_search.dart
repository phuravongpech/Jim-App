import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class CustomSelectSearch extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClear;
  final Function(String) onSearchSubmitted;

  const CustomSelectSearch({
    super.key,
    required this.searchController,
    required this.onClear,
    required this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: JimColors.white,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: JimSpacings.xs, vertical: JimSpacings.xs),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search exercises...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
          ),
          onSubmitted: onSearchSubmitted,
        ),
      ),
    );
  }
}
