import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readforme/controlsWidget.dart';
import 'package:readforme/textAre.dart';
import 'package:readforme/textRecognizer.dart';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class RecognizedText extends StatefulWidget {
  const RecognizedText({ Key? key }) : super(key: key);

  @override
  _RecognizedTextState createState() => _RecognizedTextState();
}

class _RecognizedTextState extends State<RecognizedText> {
  String text = '';
  File? image;
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  Widget build(BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
            const SizedBox(height: 8),
            buildImage(),
            const SizedBox(height: 8),
            ControlsWidget(
              onClickedPickImage: pickImage,
              onClickedScanText: scanText,
              onClickedClear: clear,
              //onClickedSpeak: () => speak(text),
            ),
            const SizedBox(height: 7),
            TextAreaWidget(
              text: text,
            ),
         /* AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 50.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: RaisedButton(
              onPressed:() {
                  listen();
                  },
              onLongPress:(){ 
                _speech.stop();
                _isListening=false;
              },
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
          ),*/
          ],
    );
  }

 /*void listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            if (_text=="open camera"){
            print(true);
            pickImage();
            setState(() {
              available=false;
            });
            }
            if (_text=="scan image"){
            print(true);
            scanText();
            }
            if (_text=="cancel"){
            print(true);
            clear();
            }
          }),
        );
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  }*/

  Widget buildImage() {
    return Container(
        child: image != null
            ? Image.file(image!)
            : Icon(Icons.photo, size: 80, color: Colors.black),
        width: MediaQuery.of(context).size.width,
        height: 455,
      );
  }

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file!.path));
  }

  Future scanText() async {
     showDialog(
      context: context,
      builder: (BuildContext) { 
        return AlertDialog(
        content: CircularProgressIndicator(
          strokeWidth: 5,
        ),);
      },
    );

    final text = await TextRecognized.recogniseText(image!);
    setText(text);
    print(text);
    speak(text);
    Navigator.of(context).pop();
  }

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

  void clear() {
    Navigator.pop(context);
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}