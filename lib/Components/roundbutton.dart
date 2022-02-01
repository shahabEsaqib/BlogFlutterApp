import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
 final String title;
  final VoidCallback onpress;

  const Roundbutton({Key? key, required this.title, required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: Colors.deepPurple,
        height: 50,
        minWidth: double.infinity,
        onPressed: onpress,
      child: Text(title,style: TextStyle(color: Colors.white),),
      ),
      
    );
  }
  
}