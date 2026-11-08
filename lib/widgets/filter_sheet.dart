import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/format.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import 'gradient.dart';
import '../models/car_filter.dart';
import '../providers/cars_provider.dart';

Future<void> showFilterSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.pal.card,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const _FilterSheet(),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();
  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late CarFilter f;

  @override
  void initState() {
    super.initState();
    f = context.read<CarsProvider>().filter;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.read<CarsProvider>();
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (_, scroll) => Column(children: [
        const SizedBox(height: 10),
        Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: context.pal.border, borderRadius: BorderRadius.circular(4))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 12, 4),
          child: Row(children: [
            Expanded(
                child: Text(l10n.filterTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
            TextButton(
                onPressed: () => setState(() => f = const CarFilter()),
                child: Text(l10n.clearAll)),
          ]),
        ),
        Expanded(
          child: ListView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              _label(l10n.sortBy),
              _chips<SortBy>(SortBy.values, {f.sort}, (s) => s.label(l10n),
                  (s) => setState(() => f = f.copyWith(sort: s)),
                  single: true),
              _label(l10n.condition),
              _chips<Condition>(
                  Condition.values,
                  {f.condition},
                  (c) => switch (c) {
                        Condition.all => l10n.all,
                        Condition.newCar => l10n.newCar,
                        Condition.used => l10n.used
                      },
                  (c) => setState(() => f = f.copyWith(condition: c)),
                  single: true),
              _label(l10n.brand),
              _chips<String>(p.brands, f.brands, (s) => s, (b) {
                final s = {...f.brands};
                s.contains(b) ? s.remove(b) : s.add(b);
                setState(() => f = f.copyWith(brands: s));
              }),
              _label(l10n.bodyType),
              _chips<String>(p.bodyTypes, f.bodyTypes, (s) => s, (b) {
                final s = {...f.bodyTypes};
                s.contains(b) ? s.remove(b) : s.add(b);
                setState(() => f = f.copyWith(bodyTypes: s));
              }),
              _label(l10n.transmission),
              _chips<String>([l10n.auto, l10n.manual],
                  {if (f.transmission != null) f.transmission!}, (s) => s,
                  (t) => setState(() => f = f.copyWith(
                      transmission: f.transmission == t ? null : t)),
                  single: true),
              _label(l10n.fuelType),
              _chips<String>(p.fuels, {if (f.fuel != null) f.fuel!}, (s) => s,
                  (t) => setState(() => f = f.copyWith(fuel: f.fuel == t ? null : t)),
                  single: true),
              _label('${l10n.price}: ${formatPrice(f.minPrice)} - ${formatPrice(f.maxPrice)}'),
              RangeSlider(
                min: 0,
                max: CarFilter.maxPriceLimit.toDouble(),
                divisions: 100,
                values: RangeValues(f.minPrice.toDouble(), f.maxPrice.toDouble()),
                onChanged: (v) => setState(() => f = f.copyWith(
                    minPrice: v.start.round(), maxPrice: v.end.round())),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: GradientButton(
              label: l10n.showResults,
              onPressed: () {
                p.setFilter(f);
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ]),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(t,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      );

  Widget _chips<T>(List<T> items, Set<T> selected, String Function(T) label,
      void Function(T) onTap,
      {bool single = false}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final i in items)
          ChoiceChip(
            label: Text(label(i)),
            selected: selected.contains(i),
            onSelected: (_) => onTap(i),
          ),
      ],
    );
  }
}

extension _SortLabel on SortBy {
  String label(AppLocale l10n) => switch (this) {
        SortBy.newest => l10n.newest,
        SortBy.priceLow => l10n.priceLow,
        SortBy.priceHigh => l10n.priceHigh,
        SortBy.mileage => l10n.leastMileage,
      };
}
