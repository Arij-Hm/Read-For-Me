import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class speaker{
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  String text='';
  
  speak(String text) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0); //0.5 a 1.5
    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
  }
}