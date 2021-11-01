// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:moovup_demo/widgets/job_card.dart';

void main() {

  testWidgets('show normal JobCard', (WidgetTester tester) async {


    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: JobCard(
          job: {
            'employment_type': {'name': 'full time'},
            'company': {'name': 'juneCompany'},
            'job_name': 'marketing assistant',
            'address': [{'address': 'Songpa-gu Seoul'}],
          },
        ),
      ),
    );

    await tester.pump(); // force update widget

    expect(find.text('full time'), findsOneWidget);
    expect(find.text('juneCompany'), findsOneWidget);
    expect(find.text('marketing assistant'), findsOneWidget);
    expect(find.text('Songpa-gu Seoul'), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    await tester.tap(find.text('juneCompany'));
    expect(find.text('marketing assistant'), findsOneWidget);
  });
}
