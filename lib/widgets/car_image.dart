import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/car.dart';

class CarImage extends StatelessWidget {
  const CarImage(this.car, {super.key, this.height, this.iconSize = 64});
  final Car car;
  final double? height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final c = Color(car.colorValue);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final placeholder = SizedBox(
      height: height,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 0.2),
            radius: 0.9,
            colors: dark
                ? [c.withValues(alpha: 0.35), const Color(0xFF101626)]
                : [c.withValues(alpha: 0.30), const Color(0xFFE6E9F3)],
          ),
        ),
        child: Center(
          child: Icon(Icons.directions_car_filled_rounded,
              size: iconSize,
              color: c.computeLuminance() > 0.75 ? AppColors.muted : c),
        ),
      ),
    );
    if (car.imageUrls.isEmpty) return placeholder;
    return ClipRRect(
      child: Image.network(
        car.imageUrls.first,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, p) => p == null ? child : placeholder,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}
