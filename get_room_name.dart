import 'file_paths.dart';


String getRoomName(String filePath) {
  // Base paths and room names
  final roomNames = {
    EntrywayFilePath: 'the entryway',
    ScratchMarksFilePath: 'the entryway with scratch marks',
    LivingRoomFilePath: 'the living room',
    TvRoomFilePath: 'the TV room',
    KitchenFilePath: 'the kitchen',
    DarkHallwayFilePath: 'the dark hallway',
  };

  // Ensure sub-paths match their parent room
  if (roomNames.containsKey(filePath)) {
    return roomNames[filePath]!;
  }

  return '';
}


bool isMainRoom(String filePath) {
  // List of main room file paths
  const mainRooms = [
    EntrywayFilePath,
    LivingRoomFilePath,
    TvRoomFilePath,
    KitchenFilePath,
    DarkHallwayFilePath,
  ];

  return mainRooms.contains(filePath);
}