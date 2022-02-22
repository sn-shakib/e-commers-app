import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController mailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  bool isvisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height:600,
        //padding: const EdgeInsets.symmetric(horizontal: 16),
        // color: Colors.white60,
        child: ListView(

          children: [
            // Container(
            //   child:Image.asset('assets/images/login.png',height: 150,width: 200,),
            // ),
           //const SizedBox(height: 20),
           Container(
             height: 450,
             padding: const EdgeInsets.symmetric(horizontal: 10),
             decoration: const BoxDecoration(
               image: DecorationImage(image: AssetImage('assets/images/new.jpg',)),
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
               color: Colors.lightGreenAccent,
             ),
             child: Column(
               children: [
                 Text('Sign up',style: GoogleFonts.aclonica(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),
                 const SizedBox(height: 30),
                 TextField(
                   onChanged: (value){
                     setState(() {

                     });
                   },
                   controller: namecontroller,
                   decoration: InputDecoration(
                     fillColor: Colors.white,
                     filled: true,
                     hintText: 'user name',prefixStyle:  GoogleFonts.aclonica(color: Colors.white,fontWeight: FontWeight.bold),
                     isDense: true,
                     prefixIcon: const Icon(Icons.account_circle),
                     suffixIcon: namecontroller.text.isEmpty ? const Text('') : GestureDetector(
                       onTap: (){
                         namecontroller.clear();
                         setState(() {
                         });
                       },
                       child: const Icon(Icons.close),
                     ) ,
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                   ),
                 ),
                 const SizedBox(height: 10),
                 TextField(
                   onChanged: (value){
                     setState(() {

                     });
                   },
                   controller: mailcontroller,
                   decoration: InputDecoration(
                     fillColor: Colors.white,
                     filled: true,
                     hintText: 'user mail',prefixStyle: GoogleFonts.aclonica(color: Colors.red,fontWeight: FontWeight.bold),
                     isDense: true,
                     prefixIcon: const Icon(Icons.mail),
                     suffixIcon:mailcontroller.text.isEmpty ?const Text('') :  GestureDetector(
                         onTap: (){
                           mailcontroller.clear();
                           setState(() {

                           });
                         },

                         child:const Icon(Icons.close)),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                   ),
                 ),
                 const SizedBox(height: 10),
                 TextField(
                   onChanged: (value){
                     setState(() {

                     });
                   },
                   controller: phonecontroller,
                   decoration: InputDecoration(
                     isDense: true,
                     fillColor: Colors.white,
                     filled: true,
                     hintText: 'your phone number',prefixStyle: GoogleFonts.aclonica(color: Colors.white,fontWeight: FontWeight.bold),
                     prefixIcon: const Icon(Icons.phone),
                     suffixIcon:phonecontroller.text.isEmpty ?const Text('') :  GestureDetector(
                         onTap: (){
                           phonecontroller.clear();
                           setState(() {

                           });
                         },

                         child:const Icon(Icons.close)),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                   ),
                 ),
                 const SizedBox(height: 10),
                 TextField(
                   obscureText: isvisible,
                   controller: passwordcontroller,
                   decoration: InputDecoration(

                     fillColor: Colors.white,
                     filled: true,
                     isDense: true,
                     hintText: 'user password',prefixStyle: GoogleFonts.aclonica(color: Colors.white,fontWeight: FontWeight.bold),
                     prefixIcon: const Icon(Icons.password),
                     suffixIcon: GestureDetector(
                         onTap: (){
                           isvisible=!isvisible;
                           setState(() {

                           });
                         },
                         child: Icon( isvisible ? Icons.visibility : Icons.visibility_off)),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),

                     ),
                   ),
                 ),
                 const SizedBox(height: 10),

                 const   SizedBox(height: 12),
                 MaterialButton(
                   minWidth: 30,
                   height: 40,
                   color: Colors.blue,
                   onPressed: (){
                     UserSignUp();
                   },child: Text('Sign up',style:GoogleFonts.aclonica(color: Colors.brown,fontWeight: FontWeight.bold,fontSize: 18),
                 ),),
                 const  SizedBox(height: 12),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(' Already have an account??',style: GoogleFonts.aclonica(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15 ),),
                     TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                     }, child: Text('Sign in',style:GoogleFonts.aclonica(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15),),),
                   ],
                 ),
               ],
             ),
           ),
          ],
        ),
      ),
    );
  }
  void  UserSignUp() async{
    //FirebaseAuth auth = FirebaseAuth.instance;
   if(namecontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty && mailcontroller.text.isNotEmpty && phonecontroller.text.isNotEmpty){
     try {
       UserCredential userCredential = await FirebaseAuth.instance
           .createUserWithEmailAndPassword(
           email: mailcontroller.text,
           password: passwordcontroller.text,);
       saverUserData();
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         showErrorDialog('The password provided is too weak.');
         print('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         showErrorDialog('The account already exists for that email.');
         print('The account already exists for that email.');
       }
     } catch (e) {
       showErrorDialog(e.toString());
       print(e);
     }
   }else{
     showErrorDialog('Please fill all fields ');
   }
  }
showErrorDialog(String errorMsg){
    showDialog(context: context, builder: (contex){
      return AlertDialog(
        title:  Text('warning'.toUpperCase(),style:GoogleFonts.aclonica(color: Colors.white,fontWeight: FontWeight.bold),),
        content: Text(errorMsg),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:  Text('Ok',style: GoogleFonts.aclonica(color: Colors.red,fontWeight: FontWeight.bold),),
          )
        ],
      );
    });
}
saverUserData(){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('users').doc(mailcontroller.text).set({
    'mail':mailcontroller.text,
    'phone':phonecontroller.text,
    'name':namecontroller.text,
    'password':passwordcontroller.text,
  });
  }

}
