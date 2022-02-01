import 'package:blog_app_flutter/Components/Roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signin extends StatefulWidget {
   Signin({ Key? key }) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
   final formkey = GlobalKey<FormState>();

   String email = "",password = "";

   bool showspinner = false;

   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController textEditingController = new TextEditingController();

  TextEditingController passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                  children: [
                    TextFormField(
                      controller: textEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email,),
                        border: OutlineInputBorder()
                        
                      ),
                      onChanged: (value){
                        email = value;
                      },
                      validator: (value){
                        return (value!.isEmpty?"enter email":null);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        controller: passwordEditingController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                          
                          hintText: "Password",
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock,),
                          border: OutlineInputBorder()
                          
                        ),
                        onChanged: (value){
                          password = value;
                        },
                        validator: (value){
                          return (value!.isEmpty?"enter password":null);
                        },
                      ),
                    ),
                    Roundbutton(title: "Register", onpress: ()async{
                      if(formkey.currentState!.validate()){
                        setState(() {
                          showspinner = true;
                        });
                       try {
                         final user =  await firebaseAuth.createUserWithEmailAndPassword(email: email.toString().trim(),password: password.toString().trim());
                         if(user != null){
                           print("Success");
                           toastmessege("user successfully created");
                           setState(() {
                          showspinner = false;
                        });

                         }
                       } catch (e) {
                         print(e.toString());
                         toastmessege( e.toString());
                         setState(() {
                          showspinner = false;
                        });
                       }
                      };
                    }),
    
                ],
                )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void toastmessege(String messege){
    Fluttertoast.showToast(
        msg: messege.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}