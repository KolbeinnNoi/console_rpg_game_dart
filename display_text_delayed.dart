import 'dart:io';
import 'dart:async';

Future<Map<int, Map<String, String>>> displayTextWithChoices(
    String filePath, Duration delay, bool showDescription) async {
  final file = File(filePath);

  if (!file.existsSync()) {
    print("Error: File not found at $filePath");
    return {};
  }

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

