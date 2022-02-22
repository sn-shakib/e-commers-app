
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_app/store_page/store_page.dart';
import 'package:full_app/user.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Details_page.dart';
class HomaePage extends StatefulWidget {
  const HomaePage({Key? key}) : super(key: key);

  @override
  _HomaePageState createState() => _HomaePageState();
}
class _HomaePageState extends State<HomaePage> {

  List _list=['Cosmetics','Consumer','Organic tea','Healthy food'];
  int selectedIndex=0;
  List items=[];
  @override
  void initState() {
    // TODO: implement initState
    getData('Cosmetics');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.menu,
            color: Colors.black,
          ),
          actions: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.search,color: Colors.black,),

            ),
            // IconButton(onPressed: (){},
            //     icon: Icon(Icons.person,color: Colors.black,)),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('EXCELLENT WORLD(s) PRODUCT',style: GoogleFonts.aleo(color: Colors.brown,fontWeight:FontWeight.bold,fontSize: 15),),
                  Text('YOUR PERFECT CHOICE!',style:  GoogleFonts.adamina(color: Colors.black,fontSize: 10),),
              const SizedBox(height: 2,),

                //  TextField(
                //   decoration: InputDecoration(
                //       //focusColor: Colors.lightGreenAccent,
                //       filled: true,
                //       suffixIcon: const Icon(Icons.search),
                //       isDense: true,
                //       hintText: 'search here',
                //       border: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Colors.grey,),
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                // ),

              const SizedBox(height:5 ,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  separatorBuilder: (context,index){
                    return const SizedBox(width: 8,);
                  },
                  itemCount: _list.length,
                  itemBuilder: (context,index){
                    return MaterialButton(
                      shape: const StadiumBorder(),
                      onPressed: (){
                        selectedIndex=index;
                        items.clear();
                        getData(_list[selectedIndex]);
                        setState(() {

                        });
                      },
                      color: selectedIndex==index?Colors.lightGreenAccent:null,
                      minWidth: 100,
                      child: Text(_list[index],style:  GoogleFonts.andada(color: selectedIndex==index? Colors.red :Colors.black87,fontSize: 15,fontWeight: FontWeight.bold),),
                    );
                  },
                ),
              ),
              Expanded(child: items.isEmpty ? const Center(child: CircularProgressIndicator()) : ListView.separated(itemBuilder: (context,index){
                return Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Image.network(items[index]['image'],height: 20,),
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(5),
                        height: 150,
                        width:100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text(items[index]['title'], style: GoogleFonts.andada(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black), overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 3,),
                         //const Text('Dipto'),
                          const SizedBox(height: 3,width: 30,),
                         MaterialButton(
                             onPressed: (){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  DetailsPage(productDetails: items[index])));
                             },
                           child:  Text('For Details',style: GoogleFonts.andada(fontSize: 15,color: Colors.black,),),
                           shape:  StadiumBorder(),
                           color: Colors.pinkAccent,
                             ),
                          const SizedBox(
                            height: 2,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text('৳ ${items[index]['price']}',style: GoogleFonts.andada(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                              const  SizedBox(width: 25,),
                              MaterialButton(
                                onPressed: (){
                                  addToCart(index);
                                  showMessage(msg: 'successfully added to cart ');
                                },
                                child:   Text('Buy Now',style: GoogleFonts.andada(fontSize: 15,color: Color(0xffc62828)),),
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
                  itemCount: items.length)),
            ],
          ),
        ),
      ),
    );
  }
  getData(String keyword) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var data= await firestore.collection(keyword).get();
    for (var doc in data.docs){
      setState(() {
        Map map={
           'title': doc['title'],
          //  'catagory': doc['catagory'],
          'image': doc['image'],
           'price': doc['price'],
          'description': doc['description'],
           //'rating': doc['rating'],

        };
        items.add(map);
      });

    }
    // print(items);

  }
  void addToCart(int index) {
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    firestore.collection('users_cart').doc(email_id).collection('cart').add({
      'title': items[index]['title'],
      //  'catagory': doc['catagory'],
      'image': items[index]['image'],
      'price': items[index]['price'],
      'description':items[index]['description'],
      'Quantity':'1'
      //'rating': doc['rating'],

    });
  }
  showMessage({required String msg}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('warning'.toUpperCase()),
        content: const Text('successfully added to cart'),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>StorePage()));
          }, child: Text('ok')),
        ],
      );
    });
  }

}
