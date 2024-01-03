import 'package:flutter/material.dart';

enum IconConstants {
  microphone('microphone'),
  appLogo('app_logo');

  const IconConstants(this.value);

  final String value;

  String get toPng => 'assets/icons/ic_$value.png';
  Image get toImage => Image.asset(
        toPng,
        width: 150,
        height: 150,
      );
}
