import 'package:flutter/material.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../widgets/gradient.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});
  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  double _price = 1000000;
  double _downPayment = 200000;
  int _months = 36;

  double get monthly =>
      (_price - _downPayment) / _months;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pal = context.pal;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.financeTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: kHeroGradient,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                Text(l10n.monthlyPayment,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14)),
                const SizedBox(height: 8),
                GradientText(
                  '${monthly.toStringAsFixed(0)} ${l10n.currency}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text('$_months ${l10n.forMonths}',
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _label(l10n.carPrice),
          _slider(_price, 100000, 5000000, (v) => setState(() => _price = v)),
          _value('${_price.toStringAsFixed(0)} ${l10n.currency}'),
          const SizedBox(height: 16),
          _label(l10n.downPayment),
          _slider(_downPayment, 0, _price, (v) => setState(() => _downPayment = v)),
          _value('${_downPayment.toStringAsFixed(0)} ${l10n.currency}'),
          const SizedBox(height: 16),
          _label(l10n.duration),
          Slider(
            value: _months.toDouble(),
            min: 12,
            max: 60,
            divisions: 12,
            label: '$_months',
            activeColor: AppColors.primary,
            inactiveColor: pal.border,
            onChanged: (v) => setState(() => _months = v.round()),
          ),
          _value('$_months ${l10n.forMonths}'),
          const SizedBox(height: 30),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _summaryRow(l10n.carPrice, '${_price.toStringAsFixed(0)} ${l10n.currency}', pal),
                  _summaryRow(l10n.downPayment, '${_downPayment.toStringAsFixed(0)} ${l10n.currency}', pal),
                  _summaryRow(l10n.financedAmount, '${(_price - _downPayment).toStringAsFixed(0)} ${l10n.currency}', pal),
                  _summaryRow(l10n.monthlyPayment, '${monthly.toStringAsFixed(0)} ${l10n.currency}', pal),
                  _summaryRow(l10n.forMonths, '$_months ${l10n.forMonths}', pal),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.disclaimer,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.w700)),
  );

  Widget _value(String t) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(t,
        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
  );

  Widget _slider(double value, double min, double max, void Function(double) onChanged) =>
      Slider(
        value: value,
        min: min,
        max: max,
        divisions: 100,
        activeColor: AppColors.primary,
        inactiveColor: Colors.grey.shade300,
        onChanged: onChanged,
      );

  Widget _summaryRow(String label, String value, AppPalette pal) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: pal.muted)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );
}
