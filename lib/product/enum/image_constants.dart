enum IconConstants {
  microphone('ic_microphone');

  const IconConstants(this.value);

  final String value;

  String get toPng => 'assets/icon/$value.png';
}
