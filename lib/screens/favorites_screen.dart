import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locales.dart';
import '../providers/cars_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/car_card.dart';
import '../widgets/state_views.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ids = context.watch<FavoritesProvider>().ids;
    final cars =
        context.watch<CarsProvider>().all.where((c) => ids.contains(c.id)).toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.favorites)),
      body: cars.isEmpty
          ? EmptyView(
              icon: Icons.favorite_border,
              title: l10n.noFavorites,
              subtitle: l10n.noFavoritesSub)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 90),
              itemCount: cars.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, i) =>
                  CarCard(cars[i], index: i, heroScope: 'fav'),
            ),
    );
  }
}
