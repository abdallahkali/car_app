import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import 'add_car_screen.dart';

Future<void> openUrl(BuildContext context, String url) async {
  final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.l10n.linkError)));
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.watch<ThemeProvider>();
    final locale = context.watch<LocaleProvider>();
    final pal = context.pal;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.more)),
      body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 40), children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              gradient: kHeroGradient, borderRadius: BorderRadius.circular(26)),
          child: const Column(children: [
            Icon(Icons.directions_car_filled_rounded,
                size: 48, color: Colors.white),
            SizedBox(height: 10),
            Text(Showroom.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
          ]),
        ),
        const SizedBox(height: 18),
        Card(
          child: SwitchListTile(
            value: theme.isDark,
            onChanged: (_) => theme.toggle(),
            activeThumbColor: AppColors.primary,
            secondary: const Icon(Icons.dark_mode_rounded, color: AppColors.primary),
            title: Text(l10n.darkMode,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            onTap: () => locale.toggle(),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.language_rounded, color: AppColors.primary, size: 22),
            ),
            title: Text(l10n.isArabic ? 'English' : 'العربية',
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(l10n.isArabic ? 'Switch to English' : 'التبديل للعربية',
                style: TextStyle(color: pal.muted)),
            trailing: const Icon(Icons.chevron_left_rounded),
          ),
        ),
        const SizedBox(height: 10),
        _tile(context, Icons.add_circle_rounded, l10n.addNewCar,
            l10n.addNewCarSub, () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddCarScreen()))),
        _tile(context, Icons.location_on_rounded, l10n.address, Showroom.address, null),
        _tile(context, Icons.schedule_rounded, l10n.workHours, Showroom.hours, null),
        _tile(context, Icons.phone_rounded, l10n.callUs, Showroom.phone,
            () => openUrl(context, 'tel:${Showroom.phone}')),
        _tile(context, Icons.chat_rounded, l10n.whatsapp, l10n.whatsappSub,
            () => openUrl(context, 'https://wa.me/${Showroom.whatsapp}')),
        _tile(context, Icons.map_rounded, l10n.map, l10n.mapSub,
            () => openUrl(context,
                'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(Showroom.address)}')),
        const SizedBox(height: 16),
        Center(
            child: Text('${l10n.version} 1.1.0',
                style: TextStyle(color: pal.muted, fontSize: 12))),
      ]),
    );
  }

  Widget _tile(BuildContext context, IconData i, String t, String s,
          VoidCallback? onTap) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          child: ListTile(
            onTap: onTap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(i, color: AppColors.primary, size: 22),
            ),
            title: Text(t, style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(s, style: TextStyle(color: context.pal.muted)),
            trailing: onTap == null ? null : const Icon(Icons.chevron_left_rounded),
          ),
        ),
      );
}
