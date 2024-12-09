import 'dart:io';
import 'dart:async';


// A function that makes the text output in bits instead of dumping it all at once in the console.
// Feels more immersive this way I would say.
Future<void> displayTextWithDelay(String filePath, Duration delay) async {
  final file = File(filePath);

  // Check if the file exists otherwise print an error and
  if (!file.existsSync()) {
    print("Error: File not found at $filePath");
    return;
  }

  // This line of code reads through the textfile and replaces all line breaks and replaces them with a space and also removes any unwanted spaces
  final text = file.readAsStringSync().replaceAll('\n', ' ').trim();

  // This line of code breaks big sentences into smaller ones 
  final List<String> sentences = text.split(RegExp(r'(?<=[.!?])\s+'));

  // display each sentence with a delay
  for (String sentence in sentences) {
    if (sentence.trim().isNotEmpty) {
      print(sentence.trim());
      await Future.delayed(delay);
    }
  }
}
