import 'dart:io';
import 'console_colors.dart';

void displaySuccessFile(String filePath) {
  // read the contents of the success file
  String content = File(filePath).readAsStringSync();

  // replace and print "Congratulations, you've beaten the game!" with green text
  print(content.replaceAll(
      "Congratulations, you've beaten the game!",
      '${green}Congratulations, you\'ve beaten the game!${end}'));
}
