import 'package:flutter/material.dart';
import '../core/theme.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      this.action});
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    AppColors.primary.withValues(alpha: 0.25),
                    AppColors.secondary.withValues(alpha: 0.15)
                  ])),
              child: Icon(icon, size: 44, color: AppColors.secondary),
            ),
            const SizedBox(height: 20),
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.pal.muted)),
            ],
            if (action != null) ...[const SizedBox(height: 20), action!],
          ]),
        ),
      );
}

class CarSkeleton extends StatelessWidget {
  const CarSkeleton({super.key});
  @override
  Widget build(BuildContext context) => Container(
        height: 280,
        decoration: BoxDecoration(
            color: context.pal.card, borderRadius: BorderRadius.circular(22)),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
        child: Row(children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
                gradient: kGradient, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w800))),
          if (trailing != null) trailing!,
        ]),
      );
}

class AnimatedEntry extends StatelessWidget {
  const AnimatedEntry({super.key, required this.child, this.index = 0});
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 350 + index.clamp(0, 6) * 70),
        curve: Curves.easeOutCubic,
        builder: (_, v, c) => Opacity(
            opacity: v,
            child: Transform.translate(offset: Offset(0, (1 - v) * 18), child: c)),
        child: child,
      );
}
