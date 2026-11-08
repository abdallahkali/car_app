import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../models/car_filter.dart';
import '../providers/cars_provider.dart';
import '../widgets/car_card.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/state_views.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final _ctrl = TextEditingController();
  bool _grid = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.watch<CarsProvider>();
    final pal = context.pal;
    final results = p.results;
    if (_ctrl.text != p.query) _ctrl.text = p.query;

    return SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                onChanged: p.setQuery,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: p.query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => p.setQuery('')),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Badge(
              isLabelVisible: p.filter.activeCount > 0,
              label: Text('${p.filter.activeCount}'),
              child: GestureDetector(
                onTap: () => showFilterSheet(context),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                      gradient: kGradient,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.tune_rounded, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Text('${results.length} ${l10n.carsCount}',
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const Spacer(),
            PopupMenuButton<SortBy>(
              onSelected: (s) => p.setFilter(p.filter.copyWith(sort: s)),
              itemBuilder: (_) => [
                for (final s in SortBy.values)
                  PopupMenuItem(value: s, child: Text(s.label(l10n)))
              ],
              child: Row(children: [
                Icon(Icons.sort_rounded, size: 20, color: pal.muted),
                const SizedBox(width: 4),
                Text(p.filter.sort.label(l10n),
                    style: TextStyle(color: pal.muted)),
              ]),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => setState(() => _grid = !_grid),
              child: Icon(
                  _grid ? Icons.view_agenda_rounded : Icons.grid_view_rounded,
                  size: 22,
                  color: AppColors.primary),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: p.loading
              ? const Center(child: CircularProgressIndicator())
              : results.isEmpty
                  ? EmptyView(
                      icon: Icons.search_off_rounded,
                      title: l10n.noResults,
                      subtitle: l10n.noResultsSub,
                      action: OutlinedButton(
                          onPressed: p.reset, child: Text(l10n.clearFilters)),
                    )
                  : _grid
                      ? GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 90),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 250,
                          ),
                          itemCount: results.length,
                          itemBuilder: (_, i) => CarCard(results[i],
                              compact: true, index: i, heroScope: 'bg'),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 90),
                          itemCount: results.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 14),
                          itemBuilder: (_, i) => CarCard(results[i],
                              index: i, heroScope: 'bl'),
                        ),
        ),
      ]),
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
