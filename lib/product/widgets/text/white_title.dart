import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WhiteTitleText extends StatelessWidget {
  const WhiteTitleText({required this.value, super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}

class WhiteSubtitleText extends StatelessWidget {
  const WhiteSubtitleText({required this.value, super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      textAlign: TextAlign.left,
    );
  }
}
