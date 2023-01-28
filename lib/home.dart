import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readforme/camScreen.dart';
import 'package:readforme/homePage.dart';
import 'package:readforme/textToSpeech.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Oops ! Cette page est en cours de construction',
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Image.asset('images/under.jpeg'),
            TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) => MainPage(title: "Texte recognizer") //RecognizedText();
                       ));
                  },
                  child: Text(
                    "Take a picture",
                    style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }
}
