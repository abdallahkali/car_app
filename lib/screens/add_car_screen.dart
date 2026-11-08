import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locales.dart';
import '../models/car.dart';
import '../providers/cars_provider.dart';
import '../widgets/gradient.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _form = GlobalKey<FormState>();
  final _brand = TextEditingController();
  final _name = TextEditingController();
  final _year = TextEditingController();
  final _price = TextEditingController();
  final _mileage = TextEditingController();
  final _fuel = TextEditingController();
  final _transmission = TextEditingController();
  final _bodyType = TextEditingController();
  final _colorName = TextEditingController();
  final _horsepower = TextEditingController();
  final _engineCc = TextEditingController();
  final _description = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    for (final c in [
      _brand, _name, _year, _price, _mileage, _fuel,
      _transmission, _bodyType, _colorName, _horsepower,
      _engineCc, _description,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _sending = true);
    try {
      final car = Car(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        brand: _brand.text.trim(),
        name: _name.text.trim(),
        year: int.parse(_year.text.trim()),
        price: int.parse(_price.text.trim()),
        mileage: int.parse(_mileage.text.trim()),
        fuel: _fuel.text.trim(),
        transmission: _transmission.text.trim(),
        bodyType: _bodyType.text.trim(),
        colorName: _colorName.text.trim(),
        colorValue: 0xFF9E9E9E,
        horsepower: int.parse(_horsepower.text.trim()),
        engineCc: int.parse(_engineCc.text.trim()),
        description: _description.text.trim(),
        features: [],
      );
      await context.read<CarsProvider>().addCar(car);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.carAdded)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.error)));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addCar)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _field(l10n.brand, _brand, Icons.label),
            const SizedBox(height: 12),
            _field(l10n.model, _name, Icons.car_repair),
            const SizedBox(height: 12),
            _field(l10n.yearMade, _year, Icons.calendar_today, numeric: true),
            const SizedBox(height: 12),
            _field(l10n.price, _price, Icons.attach_money, numeric: true),
            const SizedBox(height: 12),
            _field(l10n.mileage, _mileage, Icons.speed, numeric: true),
            const SizedBox(height: 12),
            _field(l10n.fuel, _fuel, Icons.local_gas_station),
            const SizedBox(height: 12),
            _field(l10n.trans, _transmission, Icons.swap_horiz_rounded),
            const SizedBox(height: 12),
            _field(l10n.body, _bodyType, Icons.category),
            const SizedBox(height: 12),
            _field(l10n.col, _colorName, Icons.palette),
            const SizedBox(height: 12),
            _field(l10n.powerLabel, _horsepower, Icons.bolt, numeric: true),
            const SizedBox(height: 12),
            _field(l10n.engineLabel, _engineCc, Icons.engineering, numeric: true),
            const SizedBox(height: 12),
            _field(l10n.desc, _description, Icons.description, maxLines: 3),
            const SizedBox(height: 24),
            GradientButton(
              label: l10n.addCarBtn,
              icon: Icons.add_rounded,
              loading: _sending,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, IconData icon,
      {bool numeric = false, int maxLines = 1}) => TextFormField(
    controller: ctrl,
    keyboardType: numeric ? TextInputType.number : TextInputType.text,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
    ),
    validator: (v) => (v == null || v.trim().isEmpty) ? context.l10n.required : null,
  );
}
