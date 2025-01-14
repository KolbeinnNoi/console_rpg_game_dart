import 'dart:io';
import 'file_paths.dart';
import 'console_colors.dart';

Future<bool> handleLockboxCode(
    String filePath, List<String> inventory, bool isLockboxUnlocked) async {
  final file = File(filePath);

  // check if the lockbox description file exists
  if (!file.existsSync()) {
    print('${red}Error: Lockbox file not found at $filePath.${end}');
    return isLockboxUnlocked; // Return current state
  }

  // display the lockbox description only if it is locked
  if (!isLockboxUnlocked) {
    final lockboxDescription = await file.readAsLines();
    for (final line in lockboxDescription) {
      print(line);
    }
  }

  // keep prompting the player untill they enter the correct code or exit
  while (true) {
    print(
        '\n${cyan}Enter the 4-digit combination or type "exit" to leave:${end}');
    final input = stdin.readLineSync();

    // handle invalid input
    if (input == null || input.isEmpty) {
      print('${red}\nInvalid input. Please try again.${end}');
      continue; // Prompt again
    }
    // allow the player to exit without entering a code
    if (input.trim().toLowerCase() == 'exit') {
      print('${yellow}You leave the lockbox and step back.${end}');
      return isLockboxUnlocked; // Exit without changing state
    }

    // check if the code is correct
    if (input.trim() == '3214') {
      print(
          '${green}\nThe lockbox clicks open. Inside, you find an old, rusty key.${end}');
      print("${green}The key has been added to your inventory!${end}");
      inventory.add('Rusty Key');
      return true; // update state to unlocked
    } else {
      // print a message if the code is incorrect
      print('${red}\nThe lockbox remains locked. The code is incorrect.${end}');
      print('${yellow}Hint: Explore the house for clues.${end}');
    }
  }
}
