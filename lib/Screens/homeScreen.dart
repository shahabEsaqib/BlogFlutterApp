import 'package:blog_app_flutter/Screens/addPosts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("New Blog"),
        actions: [InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosts()));
          },
          child: Icon(Icons.add)),SizedBox(width: 20,)
          ],
          
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
        ],
      ),
    );
  }
}