//import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:readforme/home.dart';
import 'package:readforme/homePage.dart';
import 'package:readforme/speechToText.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';


class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/Vector.png'),
            SizedBox(height: 60.0),
            Text(
              'You have Signed Up successfully',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50.0),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MainPage(title:'')/*Home()*/));
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),),
          ],
        ),
      ),
    );
  }
}