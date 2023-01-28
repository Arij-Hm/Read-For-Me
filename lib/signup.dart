import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readforme/success.dart';
import 'auth.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

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
            if (_text=="Take Image"){
            print(true);
            }
            if (_text=="Scan Image"){
            print(true);
            }
            if (_text=="Cancel"){
            print(true);
            }
          }),
        );
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  }

  Future<void> _submit() async {
    Provider.of<Auth>(context, listen: false)
        .signUp(_emailcontroller.toString(), _passcontroller.toString());
    print(_emailcontroller);
    print(_passcontroller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 50.0,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Entrer votre email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Mot de passe',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _passcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Entrer votre mot de passe',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Confirmer Mot de passe ',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Confimer Votre Mot de Passe',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        )),
                  ],
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    _submit();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Success()));
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}