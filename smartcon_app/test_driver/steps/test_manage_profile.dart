import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class AndProfileFields extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String text1, String text2) async {
    final text1Finder = find.text(text1);
    final text2Finder = find.text(text2);

    var finder1Exists = await FlutterDriverUtils.isPresent(world.driver, text1Finder);
    var finder2Exists = await FlutterDriverUtils.isPresent(world.driver, text2Finder);

    expectMatch(true, finder1Exists);
    expectMatch(true, finder2Exists);
  }

  @override
  RegExp get pattern => RegExp(
      r"I will be presented with {string} and {string}");
}

class AndSaveProfileButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String btn1) async {
    final btn1Finder = find.byValueKey(btn1);
    var btnFinderExists = await FlutterDriverUtils.isPresent(world.driver, btn1Finder);

    expectMatch(true, btnFinderExists);

    await FlutterDriverUtils.isPresent(world.driver, btn1Finder);
  }

  @override
  RegExp get pattern => RegExp(
      r"I will be able to save my profile by clicking the {string}");
}