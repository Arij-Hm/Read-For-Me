import 'package:flutter/material.dart';
import 'package:readforme/textToSpeech.dart';


class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child : AppBar(
          title: Text(widget.title)
    
        ),),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              RecognizedText(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}