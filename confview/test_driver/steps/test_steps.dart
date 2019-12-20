import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
class CheckGivenWidgets extends Given1WithWorld<String,FlutterWorld> {

  @override
  Future<void> executeStep(String input1) async {

    // TODO: implement executeStep

    //final textinput1 = find.byValueKey(input1);
    final button = find.byValueKey(input1);
   // await FlutterDriverUtils.isPresent(textinput1, world.driver);
    await FlutterDriverUtils.isPresent(button, world.driver);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I have {string} and {string}");}

class ClickLoginButton extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String addConferenceButton) async {
// TODO: implement executeStep
    final addConferenceFinder = find.byValueKey(addConferenceButton);
    await FlutterDriverUtils.tap(world.driver, addConferenceFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}