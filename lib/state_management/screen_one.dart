import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  // counter
  int _counter = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            "ScreenOne",
            fontSize: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Add +",
            onTap: () {
              setState(() {
                _counter++;
                isLoading = true;
              });
            },
          ),
          isLoading? const CircularProgressIndicator(): Container(),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "$_counter",
            fontSize: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Sub -",
            onTap: () {
              setState(() {
                _counter--;
                isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
