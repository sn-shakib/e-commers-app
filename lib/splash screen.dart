

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Timer(const Duration(seconds: 3),(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginPage()));
      });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.black87,
        constraints:const BoxConstraints.expand(),
        child: Column(
          children:  [
          const Padding(
            padding: EdgeInsets.all(35),
            child: CircleAvatar(
              radius: 180,
              backgroundImage: AssetImage('assets/images/eco.png',),
            ),
          ),
           const SizedBox(height: 20,),
           Text('Welcome',style: GoogleFonts.aladin(color: Colors.red,fontSize: 45)),
            Text('To',style: GoogleFonts.alata(color: Colors.lightGreen,fontSize: 20),),
           Text('Authentic Product(s) World',style: GoogleFonts.aclonica(color: Colors.amberAccent,fontSize: 20),),
           //Text(' WELCOME \n TO \n AUTHENTIC  PRODUCT(s) WORLD',style: TextStyle(fontSize: 20,color: Colors.lightGreen,fontWeight: FontWeight.bold),),
               ],
            ),


        ),

      );

  }
}
