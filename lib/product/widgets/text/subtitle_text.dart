import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({required this.value, super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(),
    );
  }
}
