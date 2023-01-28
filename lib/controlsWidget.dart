import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;
  //final onClickedSpeak;

  const ControlsWidget({
    required this.onClickedPickImage,
    required this.onClickedScanText,
    required this.onClickedClear,
    //required this.onClickedSpeak,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onClickedPickImage,
            child: Text('Take Image', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: onClickedScanText,
            child: Text('Scan Image', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
          ),
          const SizedBox(width: 16),
          /*TextButton(
            onPressed: () => onClickedSpeak,
            child: Text('Speak', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
          ),
          const SizedBox(width: 6),*/
          TextButton(
            onPressed: onClickedClear,
            child: Text('Clear', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
          )
        ],
      );
}