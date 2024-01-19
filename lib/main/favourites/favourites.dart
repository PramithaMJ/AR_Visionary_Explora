import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        "Favourite",
        fontSize: 34,
      ),
    );
  }
}
