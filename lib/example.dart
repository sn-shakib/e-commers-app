import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomaePage extends StatefulWidget {
  const HomaePage({Key? key}) : super(key: key);

  @override
  _HomaePageState createState() => _HomaePageState();
}
class _HomaePageState extends State<HomaePage> {
  List catagory=['Cosmetics','Food Supplements','Consumer','Organic-Tea','Healthy Food'];
  int selectedIndex=0;
  List items=[];
  @override
  void initState() {
    // TODO: implement initState
    getData('top');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('EXCELLENT WORLDs PRODUCT',style:  TextStyle(color: Colors.red,fontWeight:FontWeight.bold,fontSize: 23),),
              const    Text('YOUR PERFECT CHOICE!',style:   TextStyle(color: Colors.red,fontSize: 15),),
              const SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    focusColor: Colors.lightGreenAccent,
                    filled: true,
                    suffixIcon: const Icon(Icons.search),
                    isDense: true,
                    hintText: 'search here',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
              ),
              const SizedBox(height:5 ,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  separatorBuilder: (context,index){
                    return const SizedBox(width: 8,);
                  },
                  itemCount: catagory.length,
                  itemBuilder: (context,index){
                    return MaterialButton(
                      shape: const StadiumBorder(),
                      onPressed: (){
                        selectedIndex=index;
                        items.clear();
                        getData(catagory[index]);
                        setState(() {

                        });
                      },
                      color: selectedIndex==index?Colors.lightGreenAccent:null,
                      minWidth: 100,
                      child: Text(catagory[index],style: TextStyle(color: selectedIndex==index? Colors.red :Colors.black87,fontSize: 15),),
                    );
                  },
                ),
              ),
              Expanded(child: items.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.separated(itemBuilder: (context,index){
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset('assets/images/othentic.jpg'),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(10),
                        height: 150,
                        width:100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),

                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('DIPTO',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.redAccent),),
                          const SizedBox(height: 3,),
                          Text('Dipto'),
                          const SizedBox(height: 3,),
                          const Text('DIPTO'),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('50',style: TextStyle(fontSize: 15,color: Colors.brown,fontWeight: FontWeight.bold),),
                              const  SizedBox(width: 5,),
                              MaterialButton(
                                onPressed: (){},
                                child:  const Text('Buy Now',style: TextStyle(fontSize: 15,color: Color(0xffc62828)),),
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
                  itemCount: catagory.length)),



            ],
          ),
        ),
      ),
    );
  }
  getData(String keyword)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var data= await firestore.collection(keyword).get();
    for (var doc in data.docs){
      setState(() {
        Map map={
          'title': doc['title'],
          'catagory': doc['catagory'],
          'image': doc['image'],
          'price': doc['price'],
          'description': doc['description'],
          'rating': doc['rating'],

        };
        items.add(map);
      });

      print(items);
    }


  }

}
