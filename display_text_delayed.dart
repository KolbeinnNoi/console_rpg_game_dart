import 'dart:io';
import 'dart:async';
import 'console_colors.dart';
import 'file_paths.dart';

// This function is for making the text display with a delay which adds to the suspense
// It also returns choices for players to choose from
// I made it so that the player has a maximum of 3 choices for each object or room they are inspecting

Future<Map<int, Map<String, String>>> displayTextWithChoices(
    String filePath, Duration delay, bool showDescription) async {
  final file = File(filePath);


  // This checks if the file exists and if it doesn't it prints an error message
  if (!file.existsSync()) {
    print("Error: File not found at $filePath");
    return {};
  }
 
  // Read and process lines into sentances and choices
  final lines = await file.readAsLines();
  final List<String> sentences = [];
  final Map<int, Map<String, String>> choices = {};

  for (var line in lines) {
    if (line.startsWith('1.') || line.startsWith('2.') || line.startsWith('3.')) {
      final choiceParts = line.split('->');
      if (choiceParts.length == 2) {
        final choiceNumber = int.tryParse(line.substring(0, 1));
        if (choiceNumber != null) {
          choices[choiceNumber] = {
            'text': choiceParts[0].substring(2).trim(),
            'path': choiceParts[1].trim()
          };
        }
      }
    } else {
      sentences.add(line);
    }
  }


  // display room description only if showDescription is true
  if (showDescription) {
    for (var sentence in sentences) {
      if (sentence.trim().isNotEmpty) {
        print(sentence.trim());
        await Future.delayed(delay);
      }
    }
  }

  return choices;
}

