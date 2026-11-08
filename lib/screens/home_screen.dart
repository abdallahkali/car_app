import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../models/car_filter.dart';
import '../providers/cars_provider.dart';
import '../providers/recent_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../widgets/car_card.dart';
import '../widgets/gradient.dart';
import 'add_car_screen.dart';
import '../widgets/state_views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.goBrowse, required this.goFinance});
  final VoidCallback goBrowse;
  final VoidCallback goFinance;

  @override
  Widget build(BuildContext context) {
    final p = context.watch<CarsProvider>();
    final recent = context.watch<RecentProvider>().ids;
    final theme = context.watch<ThemeProvider>();
    final locale = context.watch<LocaleProvider>();
    final pal = context.pal;
    final l10n = context.l10n;
    final recentCars = [
      for (final id in recent) ...p.all.where((c) => c.id == id)
    ];

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: p.load,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l10n.welcome, style: TextStyle(color: pal.muted)),
                  const SizedBox(height: 4),
                  const Text(Showroom.name,
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                ]),
              ),
              _HeaderBtn(
                icon: Icons.language_rounded,
                onTap: () => locale.toggle(),
              ),
              const SizedBox(width: 10),
              _HeaderBtn(
                icon: Icons.add_rounded,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddCarScreen())),
              ),
              const SizedBox(width: 10),
              _HeaderBtn(
                icon: theme.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                onTap: theme.toggle,
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: GestureDetector(
              onTap: goBrowse,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: pal.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: pal.border)),
                child: Row(children: [
                  Icon(Icons.search_rounded, color: pal.muted),
                  const SizedBox(width: 10),
                  Text(l10n.searchHint,
                      style: TextStyle(color: pal.muted)),
                  const Spacer(),
                  const Icon(Icons.tune_rounded, color: AppColors.primary),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: kHeroGradient,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 12))
                ],
              ),
              child: Stack(children: [
                PositionedDirectional(
                  end: -20,
                  bottom: -20,
                  child: Icon(Icons.directions_car_filled_rounded,
                      size: 150, color: Colors.white.withValues(alpha: 0.14)),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(l10n.specialOffer,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 12),
                    Text(l10n.installmentBanner,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.3,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(l10n.installmentSub,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: goFinance,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(l10n.calculateInstallment,
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
          if (p.loading && p.all.isEmpty)
            const Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  CarSkeleton(),
                  SizedBox(height: 16),
                  CarSkeleton()
                ]))
          else if (p.error != null && p.all.isEmpty)
            SizedBox(
              height: 360,
              child: EmptyView(
                icon: Icons.wifi_off_rounded,
                title: p.error!,
                action: FilledButton(
                    onPressed: p.load, child: Text(l10n.retry)),
              ),
            )
          else ...[
            SectionTitle(l10n.browseByType),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                _Category(Icons.airport_shuttle_rounded, l10n.suv, () {
                  p.reset();
                  p.setFilter(const CarFilter(bodyTypes: {'SUV'}));
                  goBrowse();
                }),
                const SizedBox(width: 12),
                _Category(Icons.directions_car_rounded, l10n.sedan, () {
                  p.reset();
                  p.setFilter(CarFilter(bodyTypes: {l10n.isArabic ? 'سيدان' : 'Sedan'}));
                  goBrowse();
                }),
                const SizedBox(width: 12),
                _Category(Icons.electric_car_rounded, l10n.electric, () {
                  p.reset();
                  p.setFilter(CarFilter(fuel: l10n.isArabic ? 'كهرباء' : 'Electric'));
                  goBrowse();
                }),
              ]),
            ),
            SectionTitle(l10n.brands),
            SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: p.brands.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) {
                  final b = p.brands[i];
                  return GestureDetector(
                    onTap: () {
                      p.reset();
                      p.toggleBrand(b);
                      goBrowse();
                    },
                    child: SizedBox(
                      width: 64,
                      child: Column(children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                              color: pal.card,
                              shape: BoxShape.circle,
                              border: Border.all(color: pal.border)),
                          alignment: Alignment.center,
                          child: GradientText(b.characters.first,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(height: 6),
                        Text(b,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  );
                },
              ),
            ),
            SectionTitle(l10n.featuredCars),
            SizedBox(
              height: 340,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: p.featured.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) => SizedBox(
                    width: 290,
                    child: CarCard(p.featured[i], index: i, heroScope: 'f')),
              ),
            ),
            if (recentCars.isNotEmpty) ...[
              SectionTitle(l10n.recentlyViewed),
              SizedBox(
                height: 232,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: recentCars.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => SizedBox(
                      width: 180,
                      child: CarCard(recentCars[i],
                          compact: true, heroScope: 'r')),
                ),
              ),
            ],
            SectionTitle(l10n.newArrivals,
                trailing: TextButton(
                    onPressed: goBrowse, child: Text(l10n.viewAll))),
            for (final e in p.all.take(4).toList().asMap().entries)
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                  child: CarCard(e.value, index: e.key, heroScope: 'n')),
            const SizedBox(height: 12),
          ],
        ]),
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  const _HeaderBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
              color: context.pal.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: context.pal.border)),
          child: Icon(icon, size: 22),
        ),
      );
}

class _Category extends StatelessWidget {
  const _Category(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: context.pal.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: context.pal.border)),
            child: Column(children: [
              Icon(icon, size: 30, color: AppColors.secondary),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700)),
            ]),
          ),
        ),
      );
}
