import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import 'core/locales.dart';
import 'core/theme.dart';
import 'data/car_repository.dart';
import 'data/mock_car_repository.dart';
import 'providers/cars_provider.dart';
import 'package:car_showroom/providers/compare_provider.dart';
import 'providers/favorites_provider.dart';
import 'package:car_showroom/providers/recent_provider.dart';
import 'package:car_showroom/providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', '');
  await initializeDateFormatting('en', '');
  runApp(const CarShowroomApp());
}

class CarShowroomApp extends StatelessWidget {
  const CarShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CarRepository>(create: (_) => MockCarRepository()),
        ChangeNotifierProvider(
            create: (c) => CarsProvider(c.read<CarRepository>())..load()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CompareProvider()),
        ChangeNotifierProvider(create: (_) => RecentProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Builder(builder: (context) {
        final theme = context.watch<ThemeProvider>();
        final locale = context.watch<LocaleProvider>();
        return MaterialApp(
          title: Showroom.name,
          debugShowCheckedModeBanner: false,
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: theme.mode,
          locale: locale.locale,
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizationsDelegate(),
          ],
          home: const SplashScreen(),
        );
      }),
    );
  }
}
