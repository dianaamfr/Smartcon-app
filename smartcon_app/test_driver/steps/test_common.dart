import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ThenRedirectToPage extends Then1WithWorld<String, FlutterWorld> {
  ThenRedirectToPage() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 5));
  @override
  Future<void> executeStep(String page) async {
    final pageFinder = find.byValueKey(page);
    var pageFinderExists = await FlutterDriverUtils.isPresent(world.driver, pageFinder);
    expectMatch(true, pageFinderExists);
    await FlutterDriverUtils.tap(world.driver, pageFinder);
  }

  @override
  RegExp get pattern => RegExp(r"I will be redirected to the {string}");
}

class GivenPage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String page) async {
    final pageFinder = find.byValueKey(page);
    var pageFinderExists = await FlutterDriverUtils.isPresent(world.driver, pageFinder);
    expectMatch(true, pageFinderExists);
  }

  @override
  RegExp get pattern => RegExp(r"I am at the {string}");
}

class WhenTap extends When1WithWorld<String, FlutterWorld> {
  WhenTap(): super(StepDefinitionConfiguration()..timeout = Duration(seconds: 5));
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