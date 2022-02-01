import 'package:blog_app_flutter/Components/Roundbutton.dart';
import 'package:blog_app_flutter/Screens/login.dart';
import 'package:blog_app_flutter/Screens/signin.dart';

import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/logo.png")),
              SizedBox(height: 30,),
              Roundbutton(title: "Login", onpress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              }),
              SizedBox(height: 30,),
              Roundbutton(title: "Register", onpress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
              })      
            ],
          ),
        ),
      ),
      
    );
  }
}