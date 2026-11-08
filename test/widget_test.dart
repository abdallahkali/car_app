import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:car_showroom/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const CarShowroomApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
