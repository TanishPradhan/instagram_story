import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoryProgressBar extends StatelessWidget {
  StoryProgressBar({super.key, required this.percentValue});

  List<double> percentValue = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8),
      child: Row(
        children: List.generate(
          percentValue.length,
          (index) => Expanded(
            child: RProgressBar(
              percentValue: percentValue[index],
            ),
          ),
        ),
      ),
    );
  }
}

class RProgressBar extends StatelessWidget {
  double percentValue = 0.1;

  RProgressBar({super.key, required this.percentValue});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 4,
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      barRadius: const Radius.circular(12.0),
      percent: percentValue,
      progressColor: Colors.white,
      backgroundColor: Colors.grey.withOpacity(0.7),
    );
  }
}
