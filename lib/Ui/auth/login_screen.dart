import 'package:dumy/Ui/Util/Utils.dart';
import 'package:dumy/Ui/auth/SingUp.dart';
import 'package:dumy/posts/PostScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  void login(){
    _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
      Fluttertoast.showToast(msg: "succcessfully Login");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
    }).onError((error, stackTrace){
      utils().toastmessage(error.toString());});
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.deepPurple,
       title: Text("Login"),
     ),
     body: Center(
       child: Container(
         width: 350,
         height: 600,
         
         decoration: BoxDecoration(

           borderRadius: BorderRadius.circular(20)
         ),
         child: Form(
           key: _formKey,
           child:  Column(
             children: [
               TextFormField(
                 inputFormatters: [
                   LengthLimitingTextInputFormatter(50)
                 ],
                 decoration: InputDecoration(
                   hintText: "Email",
                   hintStyle: TextStyle(
                       color: Colors.grey.shade800,
                       fontSize: 20
                   ),
                   filled: true,

                   prefixIcon: Icon(Icons.person),
                 ),
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 validator: (text){
                   if(text==null || text.isEmpty){
                     return 'Email can\'t be empty';
                   }

                 },
                 onChanged: (text)=>setState(() {

                   emailcontroller.text =text;
                 }),
               ),
               SizedBox(height: 15,),
               TextFormField(
                 inputFormatters: [
                   LengthLimitingTextInputFormatter(50)
                 ],
                 decoration: InputDecoration(
                   hintText: "Password",
                   hintStyle: TextStyle(
                       color: Colors.grey.shade800,
                       fontSize: 20

                   ),
                   filled: true,
                   prefixIcon: const Icon(Icons.password),
                 ),
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 obscureText: true,
                 validator: (text){
                   if(text==null || text.isEmpty){
                     return 'Password can\'t be empty';
                   }

                 },
                 onChanged: (text)=>setState(() {

                  passwordcontroller.text =text;
                 }),
               ),
               SizedBox(height: 25,),
               ElevatedButton(
                   onPressed:(){
                     if(_formKey.currentState!.validate()){
                       login();
                     }
                   },
                   child: Text("Login")),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account "),
                   TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                   }, child: Text("SignUp")),
                 ],
               )


             ],
           ),
         ),
       ),
     ),
   );
  }
}