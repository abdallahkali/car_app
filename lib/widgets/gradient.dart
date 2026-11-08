import 'package:flutter/material.dart';
import '../core/theme.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton.icon(
          onPressed: loading ? null : onPressed,
          icon: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : (icon != null ? Icon(icon, color: Colors.white) : null),
          label: Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
      );
}

class GradientText extends StatelessWidget {
  const GradientText(this.data, {super.key, this.style});
  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => ShaderMask(
        shaderCallback: (bounds) => kGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(data, style: style ?? const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
      );
}
