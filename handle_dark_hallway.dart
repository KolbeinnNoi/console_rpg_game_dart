// Additions for the dark hallway interactions
import 'file_paths.dart';

Future<String> handleDarkHallwayInteraction(List<String> inventory) async {
  // check if the player has the Rusty Key
  // if they do they can enter the dark hallway otherwise they can't enter and a message will be displayed
  if (inventory.contains("Rusty Key")) {
    // return the normal dark hallway text file when the key is in inventory
    return DarkHallwayFilePath;
  } else {
    // redirect to the blocked message description if the key is missing
    return DarkHallwayBlockedFilePath;
  }
}

Future<String?> handleLivingRoomChoice(int choice, List<String> inventory) async {
  if (choice == 3) { // Dark hallway option
    return await handleDarkHallwayInteraction(inventory);
  }
  return null; // No special handling for other choices
}

