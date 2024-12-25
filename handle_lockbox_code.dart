import 'dart:io';
import 'file_paths.dart';
import 'console_colors.dart';

Future<void> handleLockboxCode(String filePath, List<String> inventory) async {
  final file = File(filePath);

  if (!file.existsSync()) {
    print('${red}Error: Lockbox file not found at $filePath.${end}');
    return;
  }

  // Display the lockbox description
  final lockboxDescription = await file.readAsLines();
  lockboxDescription.forEach(print);

  // Prompt for the code
  print('\nEnter the combination:');
  final input = stdin.readLineSync();

  // Check if the code is correct
  if (input == '3214') {
    print('${green}\nThe lockbox clicks open. Inside, you find an old, rusty key.${end}');
    inventory.add('Rusty Key');

    // This is just to track if the player has retrieved the key
    final keyFile = File(LockerKeyFilePath);
    await keyFile.writeAsString('Key retrieved from the lockbox.');
  } else {
    print('${red}\nThe lockbox remains locked. The code is incorrect.${end}');
  }
}