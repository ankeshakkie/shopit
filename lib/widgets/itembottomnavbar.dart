import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/constants/Constants.dart';
import 'package:shopit/database/DatabaseHandler.dart';
import 'package:shopit/model/cart_model.dart';
import 'package:shopit/repository/CartRepo.dart';
import 'package:shopit/theme/theme.dart';
import 'package:sqflite/sqflite.dart';

class ItemBottomNavBar extends StatefulWidget {
  final String product_name;
  final String product_image;
  final int product_price;
  final String product_quantity;
  const ItemBottomNavBar({super.key, required this.product_name, required this.product_image,
    required this.product_price, required this.product_quantity});

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {
   late SharedPreferences prefs;
  saveData(String key,String value) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

   Future<String> getData(String key) async {

    String? updated_key = await prefs.getString(key);
    return updated_key!;
   }

  Database? _database;






  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [

            Text(widget.product_price.toString(),
            style: TextStyle(
              fontSize: 30,
              color: MyTheme.navigation_color,
              fontWeight: FontWeight.bold
            ),),
            Spacer(),
            /*ElevatedButton.icon(
                onPressed: () async {
               //   print(widget.product_name+" "+widget.product_price.toString()+" "+widget.product_image+" ");
                  prefs = await SharedPreferences.getInstance();
                  String? last_key = await prefs.getString("Name") ?? "empty";
                  if(last_key!.contains(widget.product_name))
                    {
                      print("Duplicate data");
                      Fluttertoast.showToast(msg: "Items Already Added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white,
                      fontSize: 16.0);
                    }
                  else
                    {
                      insertData(widget.product_name, widget.product_price.toString(), widget.product_image,int.parse(widget.product_quantity));
                      saveData("Name", widget.product_name);
                    }


                },
                icon: Icon(
                  CupertinoIcons.cart_badge_plus,
                  color: Colors.white,
                ), label: Text(
              "Add To Cart",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.navigation_color),

            ),)*/

          ],
        ),
      ),
    );
  }
}
