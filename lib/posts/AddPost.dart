import 'package:dumy/Ui/Util/Utils.dart';
import 'package:dumy/posts/PostScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget{
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postcotroller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:  AppBar(title: Text("Post"),backgroundColor: Colors.deepPurple,),
     body: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Column(
         children: [
           TextFormField(
             controller: postcotroller,
             maxLines: 4,
             decoration:InputDecoration(
                border: OutlineInputBorder(),
               hintText: "Add your post",

             ),

           ),
           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){
             databaseRef.child(DateTime.now().millisecond.toString()).set({
               'title' : postcotroller.text.toString(),
               'id':  DateTime.now().millisecond.toString(),
             }).then((value) {
              utils().toastmessage('Added');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
             }).onError((error, stackTrace) {
               utils().toastmessage(error.toString());

             });

           }, child: const Text('                Add                   '))
         ],
       ),
     ),

   );

  }
}