import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopit/provider/cart_provider.dart';
import 'package:shopit/theme/theme.dart';

class Bottombar extends StatelessWidget {
   const Bottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Total:",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.navigation_color
                  ),),
                Consumer<CartProvider>(
                  builder: (context,value,child){
                    return Text(value.getTotalPrice().toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.navigation_color
                      ),);
                  },

                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyTheme.navigation_color,
              ),
              margin: EdgeInsets.symmetric(vertical: 7),
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Check Out",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}
