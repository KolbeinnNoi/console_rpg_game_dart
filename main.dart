import 'display_text_delayed.dart';
import 'file_paths.dart';
import 'dart:io';
import 'get_room_name.dart';
import 'console_colors.dart';
import 'handle_lockbox_code.dart';
import 'handle_dark_hallway.dart';
import 'display_death_file.dart';
import 'display_success_file.dart';

void main() async {
  String currentRoom = EntrywayFilePath; // start with the entryway txt file
  List<String> inventory = []; // track player's items
  Map<String, bool> visitedRooms = {}; // tracks if a room has been visited
  bool isLockboxUnlocked = false; // tracks if the lockbox is unlocked

  while (true) {
// main game loop: continue untill the player wins or loses

    // determine the current room's state
    // check if it's a main room
    // check if it's the first time visiting
    bool isMain = isMainRoom(currentRoom);
    bool isFirstVisit = !(visitedRooms[currentRoom] ?? false);

    // mark the room as visited
    visitedRooms[currentRoom] = true;

    // display the name of the room you are in for main rooms only
    // only display the description of a main room on the first visit
    // always dissplay the description of a sub room
    if (isMain) {
      if (!isFirstVisit || currentRoom != EntrywayFilePath) {
        print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
        print("-----------------------------------------");
      }
    }

    // ensure sub-elements always show their text and options
    final choices = await displayTextWithChoices(
        currentRoom,
        Duration(milliseconds: 0),
        isMain
            ? isFirstVisit
            : true // main rooms follow first-visit logic; sub-elements always display text
        );

    if (choices.isEmpty) {
      print('No actions available. Game over.');
      break;
    }

    // display choices available in the current room
    print('${yellow}\nWhat do you want to do?${end}');
    print("----------------------------------------");
    choices
        .forEach((key, value) => print('${cyan}$key. ${value['text']}${end}'));

    // get player input
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? '');
    print("----------------------------------------");

    if (choice != null && choices.containsKey(choice)) {
      final selectedPath = choices[choice]!['path']!;

      if (currentRoom == LivingRoomFilePath) {
        // handle logic for the living room
        final newPath = await handleLivingRoomChoice(choice, inventory);
        if (newPath != null) {
          currentRoom =
              newPath; // set the new room based on inventory and choice
        } else {
          currentRoom =
              selectedPath; // default to the selected path for other choices
        }
      } else if (selectedPath == FridgeLockboxOpenFilePath) {
        // logic for unlocking the fridge lockbox
        isLockboxUnlocked =
            await handleLockboxCode(selectedPath, inventory, isLockboxUnlocked);

        // redirect to the fridge if the lockbox is unlocked
        if (isLockboxUnlocked) {
          print('${blue} You close the fridge and step back${end}');
          currentRoom = KitchenFilePath; // redirect to the kitchen
        }
      } else {
        // update the currentRoom for other interactions
        currentRoom = selectedPath;
      }
    } else {
      // display this message if the player enters an invalid choice
      print('${red}Invalid choice. Try again.${end}');
    }

    // if the current room contains death_by_, display the death file with game over in red
    if (currentRoom.contains('death_by_')) {
      displayDeathFile(currentRoom);
      break;
    }

    // if the current room contains success, display the success file with congratulations in green
    if (currentRoom.contains('success')) {
      displaySuccessFile(currentRoom);
      break;
    }
  }
}
