import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/format.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../models/car.dart';
import '../providers/cars_provider.dart';
import '../providers/compare_provider.dart';
import '../widgets/car_image.dart';
import '../widgets/state_views.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ids = context.watch<CompareProvider>().ids.toList();
    final cars = context
        .watch<CarsProvider>()
        .all
        .where((c) => ids.contains(c.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.compare)),
      body: cars.isEmpty
          ? EmptyView(
              icon: Icons.compare_arrows_rounded,
              title: l10n.noCompare,
              subtitle: l10n.noCompareSub)
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                for (final car in cars) _CarCompareCard(car, l10n),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

class _CarCompareCard extends StatelessWidget {
  const _CarCompareCard(this.car, this.l10n);
  final Car car;
  final AppLocale l10n;

  @override
  Widget build(BuildContext context) {
    final pal = context.pal;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CarImage(car, height: 80, iconSize: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(car.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(formatPrice(car.price),
                          style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _row(l10n.yearLabel, '${car.year}', pal),
            _row(l10n.fuelLabel, car.fuel, pal),
            _row(l10n.transmissionLabel, car.transmission, pal),
            _row(l10n.power, '${car.horsepower} ${l10n.horsepower}', pal),
            _row(l10n.engine,
                car.engineCc == 0 ? l10n.electricEngine : '${car.engineCc} ${l10n.cc}', pal),
            _row(l10n.mileageLabel, car.isNew ? l10n.zero : formatKm(car.mileage), pal),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, AppPalette pal) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(
                child: Text(label, style: TextStyle(color: pal.muted))),
            Expanded(
                child: Text(value,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
          ],
        ),
      );
}
