import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        "Search",
        fontSize: 34,
      ),
    );
  }
}
