import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/store_page/store_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.productDetails}) : super(key: key);
  final Map productDetails;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 1;
  late int updatedPrice;
  late TextEditingController QuantityController;

 @override
  @override
  Widget build(BuildContext context) {
    updatedPrice = int.parse(widget.productDetails['price']);
    QuantityController=TextEditingController(text: quantity.toString());
    return Scaffold(
      body:  SafeArea(
        child: Container(
          constraints:const BoxConstraints.expand(),
          child: Column(
            children: [
             Row(
               children: [
                 BackButton(
                   color: Colors.orange,
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const StorePage()));
                   },

                 ),
                 IconButton(onPressed: (){}, icon: const Icon(Icons.favorite),color: Colors.red,),
               ],
             ),
             Container(
               height: 150,
               margin: EdgeInsets.all(1) ,
               padding: const EdgeInsets.all(1),
              child: Image.network(widget.productDetails['image'],height: 150,width: 200,),
             ),
              Expanded(
                child: Container(
                  height: 600,
                  padding: const EdgeInsets.only(left: 16,right: 10,bottom: 16),
                  decoration: const BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
                  ),
                  child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Padding(
                                 padding: EdgeInsets.symmetric(vertical: 16),
                                   child:  Text(widget.productDetails['title'],style: GoogleFonts.andada(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.brown),)),
                                MaterialButton(
                                  onPressed: (){},
                                child: const Text('★ 7.5'),
                                ),
                              ],
                            ),
                           Expanded(child:  SingleChildScrollView(child: Text(widget.productDetails['description'],textAlign: TextAlign.justify,style:  GoogleFonts.andada(fontSize: 14),))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Quantity:',style:  GoogleFonts.andada(fontWeight: FontWeight.bold,color: Colors.black),),
                                MaterialButton(
                                  color: Colors.lightGreen,
                                  shape: const StadiumBorder(),
                                  onPressed: (){
                                   if(quantity>1) quantity--;
                                   updatePrice();
                                    setState(() {

                                    });
                                  },
                                child:const Text('-',style: TextStyle(fontSize: 17),),
                                ),
                                Container(
                                  width: 50,
                                  child:  TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value){
                                      quantity=int.parse(value);
                                      setState(() {

                                      });
                                    },
                                    controller: QuantityController,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  color: Colors.lightGreen,
                                  shape: const StadiumBorder(),
                                  onPressed: (){
                                    quantity++;
                                    updatePrice();

                                  },
                                  child: const Text('+',style: TextStyle(fontSize: 17),),),

                              ],
                            ),
                            const Divider(
                              thickness: .5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("৳ ${int.parse(widget.productDetails['price'])* quantity}",style:  GoogleFonts.andada(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.red),),
                                MaterialButton(
                                  color: Colors.blueGrey,
                                  shape: const StadiumBorder(),
                                  onPressed: (){
                                    addToCart();
                                    showMessage(msg:"successfully added to cart");
                                  },
                                  child:  Text('Buy Now',style:  GoogleFonts.andada(color: Colors.black,fontWeight: FontWeight.bold),),),

                              ],
                            ),
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  // ৳ ${int.parse(widget.productDetails['price'])* quantity}
  void addToCart() async {
   FirebaseFirestore firestore=FirebaseFirestore.instance;
   updatePrice();
   // print(updatedPrice);
   await firestore.collection('users_cart').add({
     'title': widget.productDetails['title'],
     //  'catagory': doc['catagory'],
     'image': widget.productDetails['image'],
     'price': updatedPrice,
     'description': widget.productDetails['description'],
     'Quantity':QuantityController.text
     //'rating': doc['rating'],

   });

  }
  showMessage({required String msg}){
   showDialog(context: context, builder: (context){
     return AlertDialog(
       title: Text('warning!'.toUpperCase(),style: GoogleFonts.andada(color: Colors.red,fontWeight: FontWeight.bold),),
       content:  Text('successfully added to cart',style:GoogleFonts.andada(color: Colors.black,fontWeight: FontWeight.bold) ,),
       actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const StorePage()));
          }, child:  Text('ok',style: GoogleFonts.andada(color: Colors.blue,fontSize: 20),)),
       ],
     );
   });
  }

  updatePrice(){
    updatedPrice =  int.parse(widget.productDetails['price']) * quantity;
    setState(() {
    // print(updatedPrice);
    });
  }
}
