import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/format.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../models/car.dart';
import '../providers/compare_provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/car_details_screen.dart';
import 'car_image.dart';
import 'gradient.dart';
import 'state_views.dart';

class CarCard extends StatelessWidget {
  const CarCard(this.car,
      {super.key, this.compact = false, this.index = 0, this.heroScope = 'x'});
  final Car car;
  final bool compact;
  final int index;
  final String heroScope;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pal = context.pal;
    final fav = context.select<FavoritesProvider, bool>((f) => f.isFav(car.id));
    final cmp = context.select<CompareProvider, bool>((c) => c.has(car.id));
    final tag = 'car_${car.id}_$heroScope';

    return AnimatedEntry(
      index: index,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CarDetailsScreen(car: car, heroTag: tag))),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: pal.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: pal.border),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              Hero(
                  tag: tag,
                  child: CarImage(car,
                      height: compact ? 120 : 160, iconSize: compact ? 48 : 68)),
              PositionedDirectional(
                top: 10,
                start: 10,
                child: _Badge(car.isNew, l10n),
              ),
              PositionedDirectional(
                top: 6,
                end: 6,
                child: _RoundIcon(
                  icon: fav ? Icons.favorite : Icons.favorite_border,
                  color: fav ? AppColors.danger : Colors.white,
                  onTap: () => context.read<FavoritesProvider>().toggle(car.id),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(compact ? 12 : 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(car.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: compact ? 15 : 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                if (compact)
                  Text('${car.year} • ${car.transmission}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: pal.muted, fontSize: 12))
                else
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    _Mini('${car.year}'),
                    _Mini(car.transmission),
                    _Mini(car.fuel),
                    if (!car.isNew) _Mini(formatKm(car.mileage)),
                  ]),
                SizedBox(height: compact ? 8 : 12),
                Row(children: [
                  Expanded(
                    child: FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      fit: BoxFit.scaleDown,
                      child: GradientText(formatPrice(car.price),
                          style: TextStyle(
                              fontSize: compact ? 15 : 19,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final ok = context.read<CompareProvider>().toggle(car.id);
                      if (!ok) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(l10n.maxCompare)));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: cmp
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.compare_arrows_rounded,
                          size: 20,
                          color: cmp ? Colors.white : AppColors.primary),
                    ),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.isNew, this.l10n);
  final bool isNew;
  final AppLocale l10n;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          gradient: isNew ? kGradient : null,
          color: isNew ? null : Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(isNew ? l10n.newBadge : l10n.usedBadge,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
      );
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.color, required this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4), shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: color),
          ),
        ),
      );
}

class _Mini extends StatelessWidget {
  const _Mini(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: context.pal.bg, borderRadius: BorderRadius.circular(10)),
        child: Text(text,
            style: TextStyle(
                fontSize: 12,
                color: context.pal.muted,
                fontWeight: FontWeight.w600)),
      );
}
