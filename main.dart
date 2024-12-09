import 'display_text_delayed.dart';
import 'file_paths.dart';

void main() async {
  // Calls the intro text file
  await displayTextWithDelay(IntroFilePath, Duration(seconds: 4));
  
  
  
}