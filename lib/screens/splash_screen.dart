import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import 'main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => const MainShell(),
            transitionsBuilder: (_, a, __, child) =>
                FadeTransition(opacity: a, child: child),
          ));
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Stack(children: [
          Positioned(
            top: -120,
            right: -100,
            child: _glow(AppColors.primary, 320),
          ),
          Positioned(
            bottom: -140,
            left: -100,
            child: _glow(AppColors.secondary, 320),
          ),
          Center(
            child: FadeTransition(
              opacity: _c,
              child: ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: _c, curve: Curves.easeOutBack)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 108,
                    height: 108,
                    decoration: BoxDecoration(
                      gradient: kGradient,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 40,
                            offset: const Offset(0, 16))
                      ],
                    ),
                    child: const Icon(Icons.directions_car_filled_rounded,
                        size: 58, color: Colors.white),
                  ),
                  const SizedBox(height: 28),
                  const Text(Showroom.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(l10n.splashSub,
                      style: const TextStyle(color: Colors.white60)),
                ]),
              ),
            ),
          ),
        ]),
      );
  }

  Widget _glow(Color c, double s) => Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [c.withValues(alpha: 0.35), c.withValues(alpha: 0)]),
        ),
      );
}
