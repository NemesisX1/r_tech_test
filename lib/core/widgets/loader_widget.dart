import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.color,
    this.size = 100,
  });

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRipple(
        color: color ?? AppColors.primary,
        duration: const Duration(seconds: 1),
        size: size,
      ),
    );
  }
}
