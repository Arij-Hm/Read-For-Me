import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:readforme/homePage.dart';
import 'package:readforme/signup.dart';
import 'auth.dart';
import 'home.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  Future<void> _submit() async {
    Provider.of<Auth>(context, listen: false)
        .singin(_emailcontroller.toString(), _passcontroller.toString())
        .then((value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MainPage(title: 'Text Recognizer'))));
  }

  LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availablebiometrics;
  String autherized = "Not autherized";

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
            if (_text=="connect"){
            print(true);
            _authenticate();
            /*setState(() {
              available=false;
            });*/
            }
            if (_text=="sign up"){
            print(true);
            Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Signup()));
            }
            if (_text=="fingerprints"){
            print(true);
            _submit();
            }
          }),
        );
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  }*/
  Future<void> _cancheckBiometrics() async {
    //function that allow us to check our biometric sensors
    bool? cancheckbiometric;
    try {
      cancheckbiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = cancheckbiometric;
    });
  }

  Future<void> _getavalaiblebiometrics() async {
    List<BiometricType>? availablebiometric;
    try {
      availablebiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availablebiometrics = availablebiometric;
      print(_availablebiometrics);
    });
    print(_availablebiometrics);
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "scan your finger",
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      autherized =
          authenticated ? 'authrized success' : "failed to authenticate";
      print(autherized);
      if (authenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _cancheckBiometrics();
    _getavalaiblebiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Password',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passcontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _submit();
                        },
                        child: Text(
                          'Connect',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          _authenticate();
                        },
                        child: Text(
                          'FingerPrint',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              textBaseline: TextBaseline.ideographic),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Signup()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        textBaseline: TextBaseline.ideographic),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                        height: 50,
                      ),
                 AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 50.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed:() {
                print("fok 3la zahhi");
                  //listen();
                  },
              /*onLongPress:(){ 
                _speech.stop();
                _isListening=false;
              },*/
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}