import 'dart:io';
import 'file_paths.dart';
import 'console_colors.dart';

Future<bool> handleLockboxCode(
    String filePath, List<String> inventory, bool isLockboxUnlocked) async {
  final file = File(filePath);

  // Check if the lockbox description file exists
  if (!file.existsSync()) {
    print('${red}Error: Lockbox file not found at $filePath.${end}');
    return isLockboxUnlocked; // Return current state
  }

  // Display the lockbox description only if it is locked
  if (!isLockboxUnlocked) {
    final lockboxDescription = await file.readAsLines();
    for (final line in lockboxDescription) {
      print(line);
    }
  }

  // loop for the player to enter the code until it is correct or they exit
  while (true) {
    print(
        '\n${cyan}Enter the 4-digit combination or type "exit" to leave:${end}');
    final input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('${red}\nInvalid input. Please try again.${end}');
      continue; // Prompt again
    }

    if (input.trim().toLowerCase() == 'exit') {
      print('${yellow}You leave the lockbox and step back.${end}');
      return isLockboxUnlocked; // Exit without changing state
    }

    // Check if the code is correct
    if (input.trim() == '3214') {
      print(
          '${green}\nThe lockbox clicks open. Inside, you find an old, rusty key.${end}');
      print("${green}The key has been added to your inventory!${end}");
      inventory.add('Rusty Key');
      return true; // Update state to unlocked
    } else {
      print('${red}\nThe lockbox remains locked. The code is incorrect.${end}');
      print('${yellow}Hint: Explore the house for clues.${end}');
    }
  }
}
