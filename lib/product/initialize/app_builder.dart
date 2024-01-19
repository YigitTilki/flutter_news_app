import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBuilder {
  AppBuilder(this.child);

  final Widget? child;

  Widget build() {
    return ResponsiveBreakpoints(
      breakpoints: const [
        Breakpoint(start: 600, end: 600, name: MOBILE),
        Breakpoint(start: 800, end: 800, name: TABLET),
        Breakpoint(start: 1200, end: 1200, name: DESKTOP),
      ],
      child: child!,
    );
    /* ResponsiveBreakpoints.builder(
      child: child!,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 0, end: 450, name: TABLET),
        const Breakpoint(start: 0, end: 450, name: DESKTOP),
        const Breakpoint(start: 0, end: 1000, name: '4K'),
      ],
    ); */
  }
}
