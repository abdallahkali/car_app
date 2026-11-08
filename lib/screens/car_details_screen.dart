import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/format.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../models/car.dart';
import '../providers/compare_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/recent_provider.dart';
import '../widgets/car_image.dart';
import '../widgets/gradient.dart';
import 'booking_screen.dart';
import 'finance_screen.dart';
import 'more_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key, required this.car, required this.heroTag});
  final Car car;
  final String heroTag;
  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<RecentProvider>().add(widget.car.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final car = widget.car;
    final pal = context.pal;
    final fav = context.select<FavoritesProvider, bool>((f) => f.isFav(car.id));
    final cmp = context.select<CompareProvider, bool>((c) => c.has(car.id));
    final specs = <(IconData, String, String)>[
      (Icons.calendar_today_rounded, l10n.yearLabel, '${car.year}'),
      (Icons.speed_rounded, l10n.mileageLabel, car.isNew ? l10n.zero : formatKm(car.mileage)),
      (Icons.settings_rounded, l10n.transmissionLabel, car.transmission),
      (Icons.local_gas_station_rounded, l10n.fuelLabel, car.fuel),
      (Icons.bolt_rounded, l10n.power, '${car.horsepower} ${l10n.horsepower}'),
      (Icons.engineering_rounded, l10n.engine,
          car.engineCc == 0 ? l10n.electricEngine : '${car.engineCc} ${l10n.cc}'),
      (Icons.directions_car_rounded, l10n.structure, car.bodyType),
      (Icons.palette_rounded, l10n.color, car.colorName),
    ];

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          backgroundColor: pal.bg,
          leading: Padding(
            padding: const EdgeInsets.all(6),
            child: _Circle(
                icon: Icons.arrow_forward_rounded,
                onTap: () => Navigator.pop(context)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: _Circle(
                icon: fav ? Icons.favorite : Icons.favorite_border,
                color: fav ? AppColors.danger : null,
                onTap: () => context.read<FavoritesProvider>().toggle(car.id),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
                tag: widget.heroTag,
                child: CarImage(car, height: 300, iconSize: 120)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(car.title,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w800)),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      color: Color(car.colorValue),
                      shape: BoxShape.circle,
                      border: Border.all(color: pal.border, width: 2)),
                ),
              ]),
              const SizedBox(height: 6),
              GradientText(formatPrice(car.price),
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 18),
              Row(children: [
                Expanded(
                  child: _Action(
                    icon: Icons.compare_arrows_rounded,
                    label: cmp ? l10n.addedToCompare : l10n.addToCompare,
                    active: cmp,
                    onTap: () {
                      final ok = context.read<CompareProvider>().toggle(car.id);
                      if (!ok) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(l10n.maxCompare)));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _Action(
                    icon: Icons.calculate_rounded,
                    label: l10n.calculateInstallment,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FinanceScreen())),
                  ),
                ),
              ]),
              const SizedBox(height: 26),
              Text(l10n.specs,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.8,
                children: [
                  for (final s in specs)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: pal.card,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: pal.border)),
                      child: Row(children: [
                        Icon(s.$1, size: 22, color: AppColors.secondary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.$2,
                                    style: TextStyle(
                                        fontSize: 11, color: pal.muted)),
                                Text(s.$3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                              ]),
                        ),
                      ]),
                    ),
                ],
              ),
              const SizedBox(height: 26),
              Text(l10n.features,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: [
                for (final f in car.features)
                  Chip(
                    avatar: const Icon(Icons.check_circle_rounded,
                        size: 18, color: AppColors.success),
                    label: Text(f),
                  ),
              ]),
              const SizedBox(height: 26),
              Text(l10n.description,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(car.description,
                  style: TextStyle(height: 1.8, color: pal.muted)),
              const SizedBox(height: 110),
            ]),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: pal.card,
          border: Border(top: BorderSide(color: pal.border)),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () => openUrl(context, 'tel:${Showroom.phone}'),
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary, width: 1.5)),
              child: const Icon(Icons.phone_rounded, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GradientButton(
              icon: Icons.event_available_rounded,
              label: l10n.bookTestDrive,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BookingScreen(car: car))),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.icon, required this.onTap, this.color});
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45), shape: BoxShape.circle),
          child: Icon(icon, size: 22, color: color ?? Colors.white),
        ),
      );
}

class _Action extends StatelessWidget {
  const _Action(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.active = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary.withValues(alpha: 0.18)
                : context.pal.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: active ? AppColors.primary : context.pal.border),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      );
}
