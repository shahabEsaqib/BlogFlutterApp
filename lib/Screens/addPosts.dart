import 'dart:io';

import 'package:blog_app_flutter/Components/Roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({ Key? key }) : super(key: key);

  @override
  _AddPostsState createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {

  TextEditingController titleEditingController = new TextEditingController();
  TextEditingController descEditingController = new TextEditingController();
  final formkey = GlobalKey<FormState>();
  final postRef = FirebaseDatabase.instance.ref().child('post');
  firebase_storge.FirebaseStorage storage = firebase_storge.FirebaseStorage.instance;

  File? _image;
  final picker = ImagePicker();

  bool showspinner = false;

  Future getGaleryImage()async{
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedfile!=null){
        _image = File(pickedfile.path);
      }else{
        print("No image");
      }
    });
  }
 
  Future getCameraImage()async{

    final pickedfile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedfile!=null){
        _image = File(pickedfile.path);
      }else{
        print("No image");
      }
    });
  }
 
  void dialogBox(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
          height: 120,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  getCameraImage();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera_alt),
                  title:Text("Camera"),
                ),
              ),
              InkWell(
                onTap: (){
                  getGaleryImage();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.photo_library),
                  title:Text("Gallery"),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Posts'),
          centerTitle: true,
    
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    dialogBox();
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height *.2,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _image != null?ClipRect(
                        child: Image.file(_image!.absolute,
                        fit: BoxFit.contain,
                        height: 100,
                        width: 200, 
                        ),
                      ):Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 100,
                        height: 100,
                        child: Icon(Icons.camera_alt,
                        color: Colors.deepPurple,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Form(
                  key: formkey,
                    child: Column(
                    children: [
                      TextFormField(
                        controller: titleEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Title",
                          labelText: "Enter Post Title",
                          prefixIcon: Icon(Icons.email,),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)
                          
                        ),
                       
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: descEditingController,
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                            
                            hintText: "Description",
                            labelText: "Enter post description",
                            prefixIcon: Icon(Icons.lock,),
                            border: OutlineInputBorder(),
                             hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)
                            
                          ),
                         
                        ),
                      ),
                      Roundbutton(title: "Upload", onpress: ()async{
                      setState(() {
                        showspinner = true;
                      });
                      try {
                        int data = DateTime.now().microsecondsSinceEpoch;
                        firebase_storge.Reference ref = firebase_storge.FirebaseStorage.instance.ref('/blogapp$data');
                        firebase_storge.UploadTask uploadTask = ref.putFile(_image!.absolute);
                        await Future.value(uploadTask);
                        var newUrl =await ref.getDownloadURL();
                        postRef.child('post List').child(data.toString()).set({
                          
                        }).then((value){
                          toastmessege('Post published');
                          setState(() {
                            showspinner= false;
                          });
                        }).onError((error, stackTrace) {
                          toastmessege(error.toString());
                           setState(() {
                            showspinner= false;
                          }); 
                        });
                        
                        } catch (e) {
                        setState(() {
                          showspinner = false;
                        });
                        toastmessege(e.toString());
                      }
                        
                      }),
      
                  ],
                  )
                  ),
     
    
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toastmessege(String messege){
    Fluttertoast.showToast(
        msg: messege.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}