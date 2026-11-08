import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../providers/compare_provider.dart';
import '../providers/favorites_provider.dart';
import 'browse_screen.dart';
import 'compare_screen.dart';
import 'favorites_screen.dart';
import 'finance_screen.dart';
import 'home_screen.dart';
import 'more_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favCount = context.select<FavoritesProvider, int>((f) => f.ids.length);
    final cmpCount = context.select<CompareProvider, int>((c) => c.ids.length);
    return Scaffold(
      body: IndexedStack(index: _i, children: [
        HomeScreen(
            goBrowse: () => setState(() => _i = 1),
            goFinance: () => setState(() => _i = 2)),
        const BrowseScreen(),
        const FinanceScreen(),
        const FavoritesScreen(),
        const MoreScreen(),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cmpCount >= 2
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CompareScreen())),
              icon: const Icon(Icons.compare_arrows_rounded),
              label: Text('${l10n.compare} ($cmpCount)'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (i) => setState(() => _i = i),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              label: l10n.home),
          NavigationDestination(
              icon: const Icon(Icons.search_rounded), label: l10n.browse),
          NavigationDestination(
              icon: const Icon(Icons.calculate_outlined),
              selectedIcon: const Icon(Icons.calculate_rounded),
              label: l10n.finance),
          NavigationDestination(
              icon: Badge(
                  isLabelVisible: favCount > 0,
                  label: Text('$favCount'),
                  child: const Icon(Icons.favorite_border)),
              selectedIcon: const Icon(Icons.favorite),
              label: l10n.favorites),
          NavigationDestination(
              icon: const Icon(Icons.storefront_outlined),
              selectedIcon: const Icon(Icons.storefront),
              label: l10n.more),
        ],
      ),
    );
  }
}
