// Additions for the dark hallway interactions
import 'file_paths.dart';

Future<String> handleDarkHallwayInteraction(List<String> inventory) async {
  // Check if the player has the Rusty Key
  if (inventory.contains("Rusty Key")) {
    // Return the normal dark hallway text file when the key is in inventory
    return DarkHallwayFilePath;
  } else {
    // Redirect to the blocked description if the key is missing
    return DarkHallwayBlockedFilePath;
  }
}

Future<String?> handleLivingRoomChoice(int choice, List<String> inventory) async {
  if (choice == 3) { // Dark hallway option
    return await handleDarkHallwayInteraction(inventory);
  }
  return null; // No special handling for other choices
}

