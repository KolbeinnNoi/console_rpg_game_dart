import 'dart:io';
import 'console_colors.dart';

void displayDeathFile(String filePath) {
  // read the contents of the death file
  String content = File(filePath).readAsStringSync();

  // replace and print "Game Over." with red text
  print(content.replaceAll('Game Over.', '${red}GAME OVER!${end}'));
}



