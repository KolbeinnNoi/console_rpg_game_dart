import 'display_text_delayed.dart';
import 'file_paths.dart';
import 'dart:io';
import 'get_room_name.dart';
import 'console_colors.dart';
// void main() async {
//   // Calls the intro text file
//   await displayTextWithDelay(IntroFilePath, Duration(seconds: 4));
  
  
  
// }

void main() async {
  String currentRoom = EntrywayFilePath;
  Map<String, bool> visitedRooms = {};

  while (true) {
    // check if room was visited before
    bool isFirstVisit = visitedRooms[currentRoom] ?? false;

    // mark the room as visited
    visitedRooms[currentRoom] = true;

    // display "you are now in..." for revisits
    if (isFirstVisit) {
      print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
    }

    // display text and options
    final choices = await displayTextWithChoices(currentRoom, Duration(milliseconds: 50), !isFirstVisit);

    if (choices.isEmpty) {
      print('No actions available. Game over.');
      break;
    }

    // display choices
    print('${yellow}\nWhat do you want to do?${end}');
    choices.forEach((key, value) => print('$key. ${value['text']}'));

    // get player input
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? '');

    if (choice != null && choices.containsKey(choice)) {
      currentRoom = choices[choice]!['path']!;
    } else {
      print('Invalid choice. Try again.');
    }
  }
}


