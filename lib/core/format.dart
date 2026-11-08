import 'package:intl/intl.dart';

final _num = NumberFormat.decimalPattern('en');

String formatPrice(int v) => '${_num.format(v)} ج.م';
String formatKm(int v) => '${_num.format(v)} كم';
