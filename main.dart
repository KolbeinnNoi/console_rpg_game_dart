import 'display_text_delayed.dart';
import 'file_paths.dart';
import 'dart:io';
import 'get_room_name.dart';
import 'console_colors.dart';
import 'handle_lockbox_code.dart';
import 'handle_dark_hallway.dart';


void main() async {
  String currentRoom = EntrywayFilePath;
  List<String> inventory = []; // Track player's items
  Map<String, bool> visitedRooms = {}; // Tracks if a room has been visited
  bool isLockboxUnlocked = false; // Tracks if the lockbox is unlocked

  while (true) {
    // Check if the currentRoom is a main room
    bool isMain = isMainRoom(currentRoom);
    bool isFirstVisit = !(visitedRooms[currentRoom] ?? false);

    // Mark the room as visited
    visitedRooms[currentRoom] = true;

    // Display the room name only for main rooms
    if (isMain) {
      if (!isFirstVisit || currentRoom != EntrywayFilePath) {
        print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
        print("-----------------------------------------");
      }
    }

    // Ensure sub-elements always show their text and options
    final choices = await displayTextWithChoices(
        currentRoom,
        Duration(milliseconds: 0),
        isMain
            ? isFirstVisit
            : true // Main rooms follow first-visit logic; sub-elements always display text
        );

    if (choices.isEmpty) {
      print('No actions available. Game over.');
      break;
    }

    // Display choices
    print('${yellow}\nWhat do you want to do?${end}');
    print("----------------------------------------");
    choices
        .forEach((key, value) => print('${cyan}$key. ${value['text']}${end}'));

    // Get player input
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? '');
    print("----------------------------------------");

    // if (choice != null && choices.containsKey(choice)) {
    //   final selectedPath = choices[choice]!['path']!;

    //   if (selectedPath ==
    //       'txt_files/first_floor/kitchen/kitchen_fridge_lockbox_open.txt') {
    //     isLockboxUnlocked =
    //         await handleLockboxCode(selectedPath, inventory, isLockboxUnlocked);

    //     // Redirect to the fridge if the lockbox is unlocked
    //     if (isLockboxUnlocked) {
    //       print('${blue} You close the fridge and step back${end}');
    //       currentRoom = KitchenFilePath;
    //     }
    //   } else {
    //     // Update the currentRoom for other interactions
    //     currentRoom = selectedPath;
    //   }
    // } else {
    //   print('${red}Invalid choice. Try again.${end}');
    // }

if (choice != null && choices.containsKey(choice)) {
  final selectedPath = choices[choice]!['path']!;

  if (currentRoom == LivingRoomFilePath) {
    final newPath = await handleLivingRoomChoice(choice, inventory);
    if (newPath != null) {
      currentRoom = newPath; // Set the new room based on inventory and choice
    } else {
      currentRoom = selectedPath; // Default to the selected path for other choices
    }
  } else if (selectedPath == FridgeLockboxOpenFilePath) {
    isLockboxUnlocked =
        await handleLockboxCode(selectedPath, inventory, isLockboxUnlocked);

    // Redirect to the fridge if the lockbox is unlocked
    if (isLockboxUnlocked) {
      print('${blue} You close the fridge and step back${end}');
      currentRoom = KitchenFilePath;
    }
  } else {
    // Update the currentRoom for other interactions
    currentRoom = selectedPath;
  }
} else {
  print('${red}Invalid choice. Try again.${end}');
}


  }
}
