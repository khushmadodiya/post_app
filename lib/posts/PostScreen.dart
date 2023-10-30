import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AddPost.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(msg: "Successfully signed out");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      // Successfully signed out
    } catch (e) {
      // Handle errors, if any
      print('Error signing out: $e');
      Fluttertoast.showToast(msg: 'Error signing out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance.ref('Post');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('Post',style: TextStyle(color: Colors.white),)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()async{
            await signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PostScreen()));
          }, icon: Icon(Icons.logout_outlined),color: Colors.white,)
        ],
      ),
      floatingActionButton:FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost()));
      },
        child: Icon(Icons.add)

      ),
      body:
      // Expanded(
      //   child: StreamBuilder(
      //     builder: (context,snapshot){
      //       return ListView.builder(itemBuilder: (context,index){
      //         return ListTile(
      //
      //         );
      //       });
      //
      //     }, stream: null,
      //   ),
      // ),

      FirebaseAnimatedList(query: databaseRef,
          itemBuilder: (context,snapshot,animation,index){
             return ListTile(
               leading: Icon(Icons.person),
               title: Text(snapshot.child('title').value.toString()),
               subtitle: Text(snapshot.child('id').value.toString()),
             );
          }
      ),
    );
  }
}


