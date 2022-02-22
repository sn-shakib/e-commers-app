import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Details_page.dart';
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartData();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: items.isEmpty ? const Center(child: CircularProgressIndicator()) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('your cart have ${items.length} item (s)',style: GoogleFonts.andada(fontSize: 19,color: Colors.blueGrey),),
            SizedBox(height: 16,),
            Expanded(child: ListView.separated(itemBuilder: (context,index){
              return Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      child: Image.network(items[index]['image'],height: 50,),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      height: 150,
                      width:100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(width: 18,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(items[index]['title'],style: GoogleFonts.andada(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                        const SizedBox(height: 3,),
                         Text('Quantity:${items[index]['Quantity']}'),
                        const SizedBox(height: 3,width: 30,),
                        // MaterialButton(
                        //   onPressed: (){
                        //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  DetailsPage(productDetails: items[index])));
                        //   },
                        //   child:Text('Remove item',style: TextStyle(fontSize: 15,color: Colors.green),),
                        //   shape: StadiumBorder(),
                        //   color: Colors.pinkAccent,
                        // ),
                        const SizedBox(
                          height: 2,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('৳ ${items[index]['price']}',style:  GoogleFonts.andada(fontSize: 20,color: Colors.amber,fontWeight: FontWeight.bold),),
                            const  SizedBox(width: 25,),
                            MaterialButton(
                              onPressed: () async {
                                FirebaseFirestore firestore=  FirebaseFirestore.instance;
                                await firestore.collection('users_cart').doc(items[index]['id']).delete();
                                items.clear();
                                getCartData();
                                setState(() {

                                });
                                //removeItemFromCart();
                              },
                              child:   Text('Remove item',style: GoogleFonts.andada(fontSize: 15,color: Color(0xffc62828)),),
                              shape:  const StadiumBorder(),
                              color: Colors.lightGreen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
                separatorBuilder: (context,index){
                  return  const SizedBox(height: 10,);
                },
                itemCount: items.length),),
          ],),
        ),
      ),
    );
  }
  getCartData()async{
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    var cartData= await firestore.collection('users_cart').get();
    for (var doc in cartData.docs){
      setState(() {
        Map map={

          'title': doc['title'],
          //  'catagory': doc['catagory'],
          'image': doc['image'],
          'price': doc['price'],
          'description': doc['description'],
          'id':doc.id,
          'Quantity':doc['Quantity']
          //'rating': doc['rating'],


        };
        items.add(map);
      });
      print (items);
    }
  }

  void removeItemFromCart() {

  }
}
