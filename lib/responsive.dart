import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? tablet2;
  final Widget? tablet3;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    this.tablet2,
    this.tablet3,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet3(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
      MediaQuery.of(context).size.width <= 874;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 874 &&
      MediaQuery.of(context).size.width <= 992;

  static bool isTablet2(BuildContext context) =>
      MediaQuery.of(context).size.width >= 993 &&
      MediaQuery.of(context).size.width <= 1115;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1115;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 1120) {
      return desktop;
    } else if (size.width >= 993 && tablet != null) {
      return tablet2!;
    } else if (size.width >= 874 && tablet != null) {
      return tablet!;
    } else if (size.width >= 576 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
