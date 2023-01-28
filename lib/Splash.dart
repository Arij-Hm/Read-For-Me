import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:ui';
import 'package:readforme/authentification.dart';
import 'package:readforme/speaker.dart';
import 'package:readforme/speechToText.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  var click = true;

  void listen() async {
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
            if (_text=="get started"){
            print(true);
            Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Authentification()));
      }
          }),
        );
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  /*if (_text=="get started"){
          print(true);
          Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Authentification()));
      }*/
  }

  speak(String text) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0); //0.5 a 1.5
    //await flutterTts.speak(textEditingController.text);
    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed:() {
                  listen();
                  },
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
          ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('images/RPC-JP_Logo.png')),
              SizedBox(
                height: 40,
              ),
              Text(
                'Welcome to Read For Me, you will be guided all along this experience. Live the digitalisation experience, scan your texts and translate them to speech.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              
              SizedBox(
                height: 40,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    speak('Welcome Read For Me, you will be guided all along this experience. Live the digitalisation experience, scan your texts and translate them to speech.');
                    Future.delayed(Duration(seconds: 9),(){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Authentification()));
                    });
                  },
                  child: Text('Get Started',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),),
                ),
              /*TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    speak('Welcome to your app, you will be guided all along this experience. Live the digitalisation experience, scan your texts and translate them to speech.');
                  },
                  child: Text('Speaker',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),),
                ),*/
            ],
          ),
        ),
      ),
    ));
  }
}
