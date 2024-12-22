import 'display_text_delayed.dart';
import 'file_paths.dart';
import 'dart:io';
import 'get_room_name.dart';
import 'console_colors.dart';


// void main() async {
//   String currentRoom = EntrywayFilePath;
//   bool isIntro = true; // Flag to handle intro text differently

//   while (true) {
//     // Display the room name, but skip for the intro text
//     if (!isIntro) {
//       print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
//       print("-----------------------------------------");
//     }

//     // Display text and options
//     final choices = await displayTextWithChoices(
//       currentRoom,
//       Duration(milliseconds: 50),
//       true
//     );

//     // Turn off the intro flag after the first room's text is displayed
//     isIntro = false;

//     if (choices.isEmpty) {
//       print('No actions available. Game over.');
//       break;
//     }

//     // Display choices
//     print('${yellow}\nWhat do you want to do?${end}');
//     print("----------------------------------------");
//     choices.forEach((key, value) => print('$key. ${value['text']}'));

//     // Get player input
//     final input = stdin.readLineSync();
//     final choice = int.tryParse(input ?? '');
//     print("----------------------------------------");

//     if (choice != null && choices.containsKey(choice)) {
//       currentRoom = choices[choice]!['path']!;
//     } else {
//       print('Invalid choice. Try again.');
//     }
//   }
// }


void main() async {
  String currentRoom = EntrywayFilePath;
  bool isIntro = true; // Handle intro text separately
  bool displayRoomName = true; // Controls whether to show "You are now in..."

  while (true) {
    // Display the room name only for main room entries
    if (!isIntro && displayRoomName) {
      print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
      print("-----------------------------------------");
    }

    // Display text and options
    final choices = await displayTextWithChoices(
      currentRoom,
      Duration(milliseconds: 50),
      true
    );

    // After the intro, disable the intro flag
    isIntro = false;

    if (choices.isEmpty) {
      print('No actions available. Game over.');
      break;
    }

    // Display choices
    print('${yellow}\nWhat do you want to do?${end}');
    print("----------------------------------------");
    choices.forEach((key, value) => print('${cyan}$key. ${value['text']}${end}'));

    // Get player input
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? '');
    print("----------------------------------------");

    if (choice != null && choices.containsKey(choice)) {
      // Update the currentRoom and determine if it is a main room
      final nextRoom = choices[choice]!['path']!;
      displayRoomName = isMainRoom(nextRoom); // Update display control
      currentRoom = nextRoom;
    } else {
      print('Invalid choice. Try again.');
    }
  }
}

