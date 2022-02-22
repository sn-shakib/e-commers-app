import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_app/login.dart';
import 'package:full_app/user.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  late TextEditingController namecontroller;
 late TextEditingController phonecontroller;
  @override
  Widget build(BuildContext context) {
    namecontroller=TextEditingController(text: user_name);
    phonecontroller= TextEditingController(text:  phone_number);
    return  Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person,
            size: 50,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children:  [
                  const Icon(Icons.person),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(user_name ?? 'null',style: GoogleFonts.andada(fontSize: 18,color: Colors.black),),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children:  [
                  const Icon(Icons.mail),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(email_id ?? 'null',style:GoogleFonts.andada(fontSize: 18,color: Colors.black),),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children:  [
                  const Icon(Icons.phone),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(phone_number ?? 'null',style:GoogleFonts.andada(fontSize: 18,color: Colors.black),),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                minWidth: 50,
                  color: Colors.blue,
                  onPressed: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                  },

                  child:  Text('Log out',style: GoogleFonts.andada(fontWeight: FontWeight.bold,color: Colors.black),)),
              MaterialButton(
                  minWidth: 100,
                  color: Colors.blue,
                  onPressed: (){
                    editeProfile();
                  },
                  child:  Text('Edit profile',style:  GoogleFonts.andada(fontWeight: FontWeight.bold,color: Colors.black),)),
            ],
          ),
        ],
      ),
      ),
    );
  }
  getData() async{
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    var userData= await firestore.collection('users').doc(email_id).get();

     email_id=userData['mail'];
     user_name=userData['name'];
     phone_number=userData['phone'];
    print(userData['mail']);
    print(userData['name']);
    print(userData['phone']);
    setState(() {

    });
  }
  editeProfile() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title:  Text('Update your profile',style: GoogleFonts.andada(color: Colors.red),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
              ),
            ),
             TextField(
              controller: phonecontroller,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
              ),
            ),
          ],
        ),
        actions: [
       TextButton(
         onPressed: (){
           updateProfile();
           Navigator.pop(context);
           getData();
         },
         child:  Text('Ok',style: GoogleFonts.andada(color: Colors.black),),
       ),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child:  Text('Cancel',style:  GoogleFonts.andada(color: Colors.red),),
          ),
        ],
      );
    });
  }
  updateProfile() async{
    FirebaseFirestore firestore=await FirebaseFirestore.instance;
    firestore.collection('users').doc(email_id).update({
 'name':namecontroller.text,
 'phone':phonecontroller.text,

    });
  }
}
