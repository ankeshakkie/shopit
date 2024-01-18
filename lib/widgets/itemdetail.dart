import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopit/theme/theme.dart';
import 'package:shopit/widgets/itembottomnavbar.dart';
import '../model/selling_model.dart';
import 'itempage.dart';

class Itemdetail extends StatefulWidget
{
  final List<dynamic> itemImageList;
  final String product_title;
  final String product_description;
  final int product_price;


  Itemdetail({required this.itemImageList,required this.product_title, required this.product_description,
    required this.product_price});

  @override
  State<Itemdetail> createState() => _ItemdetailState();
}

class _ItemdetailState extends State<Itemdetail> {

  int count = 1;

  List<Color> clrs  = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.orange
  ];

  int active_index = 0;
  
  @override
  Widget build(BuildContext context) {
    
    print("Titlename"+widget.itemImageList[2].toString());
    return Scaffold(
     backgroundColor: MyTheme.background_color,
     body: ListView(
         children: [
           ItemPage(),
           Padding(
             padding: EdgeInsets.only(top: 10),
             child: CarouselSlider(
               options: CarouselOptions(

                   height: 200,
                   onPageChanged: (index,reason){
                     setState(() {
                       active_index = index;
                     });
                   },
                   autoPlay: true,
                   viewportFraction: 1),
               items: widget.itemImageList.map((i) {
                 return Builder(
                   builder: (BuildContext context) {
                     return Card(
                       child: Image.network(i,
                         fit: BoxFit.cover,
                       ),
                     );
                   },
                 );
               }).toList(),

             ),
           ),
           Arc(
             edge:Edge.TOP ,
               arcType: ArcType.CONVEY,
               height: 30,
               child: Container(
               width: double.infinity,
               color: Colors.white,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                   children: [
                     Padding(
                         padding: EdgeInsets.only(
                           top: 50,bottom: 20
                         ),
                       child: Row(
                         children: [
                           Text(widget.product_title,

                           style: TextStyle(
                             fontSize: 28,
                             color: MyTheme.navigation_color,
                             fontWeight:FontWeight.bold
                           ),)
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.only(bottom: 10),
                       child: Row(
                         children: [
                           RatingBar.builder(
                             itemCount: 5,
                               direction: Axis.horizontal,
                               glowColor: MyTheme.navigation_color,
                               initialRating: 4,
                               minRating: 1,
                               itemSize: 20,
                               itemPadding: EdgeInsets.symmetric(horizontal: 4),
                               itemBuilder: (context,_)=>Icon(Icons.favorite,
                                 color: MyTheme.navigation_color,),
                               onRatingUpdate: (index){}),
                           Spacer(),


                         ],

                       ),
                     ),
                     Padding(
                         padding: EdgeInsets.symmetric(vertical: 12,),
                     child: Text(widget.product_description,
                     textAlign: TextAlign.justify,
                     style: TextStyle(
                       fontSize: 17,
                       color: MyTheme.navigation_color,

                     ),),),
                     Row(
                       children: [
                         Padding(
                             padding: EdgeInsets.only(top: 12,bottom: 12),
                         child: Text("Size:",
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                           color: MyTheme.navigation_color
                         ),),),
                         SizedBox(width: 10,),
                         Row(
                           children: [
                             for(int i=5;i<10;i++)
                             Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(30),
                                 boxShadow:[
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(0.5),
                                     spreadRadius: 2,
                                     blurRadius: 8,
                                     offset: Offset(0, 3)
                                   )
                                 ]
                               ),
                               height: 30,
                               width: 30,
                               alignment: Alignment.center,
                               margin: EdgeInsets.symmetric(horizontal: 5),
                               child: Text("$i",
                               style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                                 color: MyTheme.navigation_color
                               ),),
                             )
                           ],
                         )
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Padding(
                           padding: EdgeInsets.only(top: 12,bottom: 12),
                           child: Text("Colors:",
                             style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                                 color: MyTheme.navigation_color
                             ),),),
                         SizedBox(width: 10,),
                         Row(
                           children: [
                             for(int i=0;i<5;i++)
                               Container(
                                 decoration: BoxDecoration(
                                     color: clrs[i],
                                     borderRadius: BorderRadius.circular(30),
                                     boxShadow:[
                                       BoxShadow(
                                           color: Colors.grey.withOpacity(0.5),
                                           spreadRadius: 2,
                                           blurRadius: 8,
                                           offset: Offset(0, 3)
                                       )
                                     ]
                                 ),
                                 height: 30,
                                 width: 30,
                                 alignment: Alignment.center,
                                 margin: EdgeInsets.symmetric(horizontal: 5),

                               )
                           ],
                         )
                       ],
                     )
                   ],
                 ),
               ),
               ))
         ],
     ),
      bottomNavigationBar: ItemBottomNavBar(product_name: widget.product_title,
          product_image: widget.itemImageList[0], product_price: widget.product_price, product_quantity: count.toString()),

    );
  }
}
