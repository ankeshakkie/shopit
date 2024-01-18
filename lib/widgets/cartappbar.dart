import 'package:flutter/material.dart';
import 'package:shopit/theme/theme.dart';

class CartApp extends StatelessWidget {
  const CartApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
           children: [
             InkWell(
               onTap: (){
                 Navigator.pop(context);
               },
               child: Icon(Icons.arrow_back,
          color: MyTheme.navigation_color,
        ),
             ),
             Padding(
               padding: EdgeInsets.only(left: 20),
               child: Text("Cart",
               style: TextStyle(
                 fontSize: 23,
                 fontWeight: FontWeight.bold,
                 color: MyTheme.navigation_color

               ),),
             ),
             Spacer(),
             Icon(Icons.more_vert,
             size: 30,
             color: MyTheme.navigation_color,)
           ],
          ),

        ));
  }
}
