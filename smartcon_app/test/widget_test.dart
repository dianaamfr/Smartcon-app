import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartcon_app/view/insertConference/conferenceSessions.dart';
import 'package:smartcon_app/view/insertConference/insertConference.dart';
import 'package:smartcon_app/view/insertConference/newSession.dart';

void main() {
  testWidgets('Popup if pressing NEXT and form is not filled',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: InsertConference()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('insert_conference_next')));
    await tester.pumpAndSettle();
    final nameError = find.text('Conference data is invalid');
    await tester.pumpAndSettle();
    expect(nameError, findsOneWidget);
  });

  testWidgets('Pressing Insert Conference', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: InsertConference()));
    final insertConferencesPage = find.text("Insert Conference");
    expect(insertConferencesPage, findsOneWidget);
    expect(find.byType(TextFormField),
        findsNWidgets(3)); //Name, Description, Website
    expect(find.byType(RaisedButton), findsOneWidget); //Next
    expect(find.byType(MaterialButton), findsOneWidget); //Date
    expect(find.byType(DropDownFormField),
        findsNWidgets(2)); //District and Category
  });
  group('Conference Sessions', () {
    testWidgets('Testing Conference Sessions Screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: conferenceSessions()));
      expect(find.text("Conference Sessions"), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNWidgets(2)); //Next
    });
    testWidgets('Pressing okay symbol without topis -> error',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: conferenceSessions()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('btn2')));
      await tester.pumpAndSettle();
      expect(find.text("You must insert at least one session"), findsOneWidget);
    });

    testWidgets('Pressing + symbol', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: conferenceSessions()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('btn1')));
      await tester.pumpAndSettle();
      expect(find.text("New Session"), findsOneWidget);
    });
  });

  group('New Session', () {
    testWidgets('Testing New Session Screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NewSession()));
      await tester.pump();
      expect(find.text('New Session'), findsOneWidget);
      expect(find.byType(TextFormField),
          findsNWidgets(3)); //Name, Description, Website
      expect(find.byType(RaisedButton), findsNWidgets(2)); //Topics
      expect(find.byType(MaterialButton), findsNWidgets(2)); //Date, Speakers
    });
    testWidgets('Pressing Insert Topics', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NewSession()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('topicsButtonn')));
      await tester.pumpAndSettle();
      expect(find.text("Insert Topics"), findsOneWidget);
    });

    testWidgets('Pressing Insert Speakers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NewSession()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('speakerButtonn')));
      await tester.pumpAndSettle();
      expect(find.text("Insert Speakers"), findsOneWidget);
    });
  });
}
