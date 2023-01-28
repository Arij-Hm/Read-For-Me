import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextRecognized {
  static Future<String> recogniseText(File imageFile) async {
    if (imageFile == null) {
      return 'No selected image';
    } else {
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final textDetector = GoogleMlKit.vision.textDetector();
      File? _image = File(imageFile.path);
      try {
        final visionText = await textDetector.processImage(inputImage);
        await textDetector.close();

        final text = extractText(visionText);
        return text.isEmpty ? 'No text found in the image' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }

  static extractText(RecognisedText visionText) {
    String text = '';

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          text = text + word.text + ' ';
        }
        text = text + '\n';
      }
    }

    return text;
  }
}