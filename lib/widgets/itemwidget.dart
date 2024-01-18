import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/Urls/all_url.dart';
import 'package:shopit/provider/cart_provider.dart';
import 'package:shopit/theme/theme.dart';
import 'package:shopit/utils/routes.dart';
import 'package:shopit/widgets/itemdetail.dart';
import 'package:sqflite/sqflite.dart';

import '../database/DatabaseHandler.dart';
import '../model/cart_model.dart';
import '../model/selling_model.dart';
import 'package:http/http.dart' as http;

import '../repository/CartRepo.dart';

class ItemWidget extends StatefulWidget
{
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
List<BestSelling> proList = [];

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







Future<BestSelling?> getAllProducts() async {
  var response = await http.get(Uri.parse(AllUrls.best_selling_url));
  var whole_data = jsonDecode(response.body.toString());
  if(response.statusCode==200)
    {
      setState(() {

      });

      List<dynamic> products = whole_data['products'];
      print("list_data "+products.length.toString());
      print("whole_data"+whole_data.toString());

      for(var fetchlist in products)
        {
          int id = fetchlist['id'];
          String title = fetchlist['title'];
          print("titlesolo $title");
          String description = fetchlist['description'];
          int price = fetchlist['price'];
          String thumbnail = fetchlist['thumbnail'];
          List<dynamic> all_image = fetchlist['images'];
          proList.add(BestSelling(id:id,title: title, description: description, price: price, thumbnmail: thumbnail, proImages: all_image));
        }

    }
  else{
      print("response fail");
  }

}

@override
  void initState() {

    super.initState();
    getAllProducts();
    setState(() {

    });
  }


@override
  void dispose() {

  }

  @override
  Widget build(BuildContext context)
  {
    final cart = Provider.of<CartProvider>(context);
    print("Productlist"+proList.length.toString());
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    childAspectRatio: 1/1.7,
    children: [
      if(proList.isNotEmpty)
        for(int i=1;i<proList.length;i++)
          InkWell(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Itemdetail(itemImageList: proList[i].proImages, product_title: proList[i].title.toString(), product_description: proList[i].description,
                  product_price: proList[i].price)));
            },
            child: Container(
              padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: MyTheme.navigation_color,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "-50%",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Itemdetail(itemImageList: proList[i].proImages, product_title: proList[i].title.toString(), product_description: proList[i].description,
                          product_price: proList[i].price)));
                    },
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Image.network(proList[i].thumbnmail,
                          height: 100,
                          width: 100,)
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      proList[i].title,
                      style: TextStyle(
                          color: MyTheme.navigation_color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "This is description",
                      style: TextStyle(
                          fontSize: 14,
                          color:MyTheme.navigation_color
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          proList[i].price.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.navigation_color
                          ),
                        ),
                        Icon(Icons.shopping_cart_checkout,
                          color: MyTheme.navigation_color,)
                      ],
                    ) ,),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: ()  {



                        CartRepo().createTable(_database);
                        CartRepo().insertData(_database, CartModel(
                            id: proList[i].id,
                            name: proList[i].title,
                            initial_price: proList[i].price,
                            products_price: proList[i].price,
                            image: proList[i].proImages[0].toString(),
                            quantity: 1)).then((value){

                              AwesomeDialog(
                                context: context,
                                showCloseIcon: true,
                                autoDismiss: true,
                                dialogType: DialogType.SUCCES,
                                title: proList[i].title+" added Sucessfully"
                                ).show();
                              cart.addCounter();
                              cart.addTotalPrice(double.parse(proList[i].price.toString()));


                        }).onError((error, stackTrace){
                            print(error.toString());
                        });

                      },
                      icon: Icon(
                        CupertinoIcons.cart_badge_plus,
                        color: Colors.white,
                        size: 20,
                      ), label: Text(
                      "Add To Cart",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyTheme.navigation_color),

                      ),),
                  ),
                ],
              ),
            ),
          )
      else
        Container(
          alignment: Alignment.bottomRight,
          child: CircularProgressIndicator(),
        )
    ],);
  }
}
