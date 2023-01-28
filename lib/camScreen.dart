import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:async';

import 'package:readforme/textToSpeech.dart';

class CamScreen  extends StatefulWidget {
  const CamScreen({ Key? key }) : super(key: key);

  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  String result="";
  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();
  String texte="";

/*Future pickImageFromGallery() async {
   final pickedFile = await picker.getImage(source: ImageSource.gallery);
 
   setState(() {
     if (pickedFile != null) {
       _image = File(pickedFile.path);
       inputImage = InputImage.fromFilePath(pickedFile.path);
       imageToText(inputImage);
     } else {
       print('No image selected.');
     }
   });
}*/

Future captureImageFromCamera() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);
  final textDetector = GoogleMlKit.vision.textDetector();
  RecognisedText recognisedText;

   setState(() async {
     if (pickedFile != null) {
      _image = File(pickedFile.path);
      inputImage = InputImage.fromFilePath(pickedFile.path);
      recognisedText = await textDetector.processImage(inputImage!);
       imageToText(recognisedText);
     } else {
       print('No image selected.');
     }
   });
 }

  /*Future imageToText(inputImage) async {
    result = ''; 
  
    setState(() {
      String text = recognisedText.text;
      for (TextBlock block in recognisedText.blocks) {
        //each block of text/section of text
        final String text = block.text;
        print("block of text: ");
        print(text);
        for (TextLine line in block.lines) {
            //each line within a text block
          for (TextElement element in line.elements) {
            //each word within a line
            result += element.text + " ";
          }
        }
      }
      result += "\n\n";
      print(result);
    });
  }*/
  static imageToText(RecognisedText visionText) {
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    captureImageFromCamera();
                    Future.delayed(Duration(seconds:5));
                    /*Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) => RecognizedText(text: result)));*/
                  },
                  child: Text(
                    "Take a picture",
                    style: TextStyle(color: Colors.white),
                ),
              ),
    ),
    ),
    );
  }
}