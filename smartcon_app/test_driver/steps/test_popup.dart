import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenInsertConferencePage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final homeFinder = find.byValueKey('home_page');
    var homeFinderExists = await FlutterDriverUtils.isPresent(world.driver, homeFinder);

    expectMatch(true, homeFinderExists);

    final btnFinder = find.byValueKey('insert_conference_btn');
    var btnFinderExists = await FlutterDriverUtils.isPresent(world.driver, btnFinder);

    expectMatch(true, btnFinderExists);
    await FlutterDriverUtils.tap(world.driver, btnFinder);

    final insertConferenceFinder = find.byValueKey('insert_conference_page');
    var insertConferenceFinderExists = await FlutterDriverUtils.isPresent(world.driver, insertConferenceFinder);

    expectMatch(true, insertConferenceFinderExists);
  }

  @override
  RegExp get pattern => RegExp(r"I am at the Insert Conference Page");
}

class ThenPopup extends Then1WithWorld<String, FlutterWorld> {

  @override
  Future<void> executeStep(String page) async {
    final popupFinder = find.byValueKey(page);
    var popupFinderExists = await FlutterDriverUtils.isPresent(world.driver, popupFinder);
    expectMatch(true, popupFinderExists);
  }

  @override
  RegExp get pattern => RegExp(r"An {string} popup will show");
}

class AndTap extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String btn) async {

    final btnfinder = find.byValueKey(btn);
    var btnFinderExists = await FlutterDriverUtils.isPresent(world.driver, btnfinder);
    expectMatch(true, btnFinderExists);

    await FlutterDriverUtils.tap(world.driver, btnfinder);
  }
  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}