import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../core/locales.dart';
import '../core/theme.dart';
import '../data/car_repository.dart';
import '../models/booking.dart';
import '../models/car.dart';
import '../widgets/gradient.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.car});
  final Car car;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _notes = TextEditingController();
  DateTime? _date;
  String? _time;
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _notes.dispose();
    super.dispose();
  }

  List<String> _getSlots(AppLocale l10n) {
    if (l10n.isArabic) {
      return ['10:00 ص', '12:00 م', '2:00 م', '4:00 م', '6:00 م', '8:00 م'];
    }
    return ['10:00 AM', '12:00 PM', '2:00 PM', '4:00 PM', '6:00 PM', '8:00 PM'];
  }

  Future<void> _pickDate() async {
    final l10n = context.l10n;
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      locale: l10n.isArabic ? const Locale('ar') : const Locale('en'),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final okForm = _form.currentState!.validate();
    if (_date == null || _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.selectDateTime)));
      return;
    }
    if (!okForm) return;

    setState(() => _sending = true);
    try {
      await context.read<CarRepository>().submitBooking(Booking(
            carId: widget.car.id,
            name: _name.text.trim(),
            phone: _phone.text.trim(),
            date: _date!,
            time: _time!,
            notes: _notes.text.trim(),
          ));
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 56),
          title: Text(l10n.bookingConfirmed),
          content: Text(
              '${l10n.bookingSub} ${widget.car.title}.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(l10n.ok))
          ],
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.error)));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bookingTitle)),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.directions_car, color: AppColors.primary),
              title: Text(widget.car.title,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Text('${widget.car.year}'),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: l10n.name, prefixIcon: const Icon(Icons.person_outline)),
            validator: (v) =>
                (v == null || v.trim().length < 3) ? l10n.nameValidation : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: l10n.phone, prefixIcon: const Icon(Icons.phone_outlined)),
            validator: (v) => RegExp(r'^01[0125][0-9]{8}$').hasMatch(v?.trim() ?? '')
                ? null
                : l10n.phoneValidation,
          ),
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: _pickDate,
            child: InputDecorator(
              decoration: InputDecoration(
                  labelText: l10n.date, prefixIcon: const Icon(Icons.event)),
              child: Text(_date == null
                  ? l10n.selectDate
                  : DateFormat('EEEE d MMMM', l10n.isArabic ? 'ar' : 'en').format(_date!)),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.time, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final s in _getSlots(l10n))
              ChoiceChip(
                  label: Text(s),
                  selected: _time == s,
                  onSelected: (_) => setState(() => _time = s)),
          ]),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notes,
            maxLines: 3,
            decoration: InputDecoration(labelText: l10n.notes),
          ),
          const SizedBox(height: 24),
          GradientButton(
            label: l10n.confirmBooking,
            icon: Icons.check_rounded,
            loading: _sending,
            onPressed: _submit,
          ),
        ]),
      ),
    );
  }
}
