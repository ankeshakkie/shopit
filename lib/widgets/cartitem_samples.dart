import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/model/cart_model.dart';
import 'package:shopit/provider/cart_provider.dart';

import 'package:shopit/widgets/cartpage.dart';
import 'package:sqflite/sqflite.dart';

import '../database/DatabaseHandler.dart';
import '../repository/CartRepo.dart';

import '../theme/theme.dart';

class CartItemSamples extends StatefulWidget {

  CartItemSamples({super.key});


  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Database? _database;
    print("widget_build");
    final cart = Provider.of<CartProvider>(context);
    return FutureBuilder(
        future: cart.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(left: 15),
                          child: Image.network(
                            snapshot.data![index].image,
                            fit: BoxFit.cover,
                            height: 70,
                            width: 70,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              snapshot.data![index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.navigation_color),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              snapshot.data![index].products_price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: MyTheme.navigation_color),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onTap: () {
                                  CartRepo().delete(_database, snapshot.data![index].id);
                                  cart.removeTotalPrice(double.parse(snapshot.data![index].initial_price.toString()));
                                  cart.removeCounter();
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {

                                      int quant = snapshot.data![index].quantity;
                                      if(quant>0)
                                        {
                                          quant++;
                                          int update_price = int.parse(snapshot.data![index].initial_price.toString()) * quant;
                                          CartRepo().update(_database, CartModel(
                                              id: snapshot.data![index].id,
                                              name: snapshot.data![index].name,
                                              initial_price: snapshot.data![index].initial_price,
                                              products_price: update_price,
                                              image: snapshot.data![index].image,
                                              quantity: quant)).then((value){

                                            cart.addTotalPrice(double.parse(snapshot.data![index].initial_price.toString()));
                                            update_price = 0;
                                            quant = 0;


                                          }).onError((error, stackTrace){
                                            print(error.toString());
                                          });
                                        }


                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              spreadRadius: 1,
                                              blurRadius: 10)
                                        ],
                                      ),
                                      child: Icon(
                                        CupertinoIcons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      snapshot.data![index].quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.navigation_color),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {

                                      int quant = snapshot.data![index].quantity;
                                      if(quant>1)
                                      {
                                        quant--;
                                        int update_price = int.parse(snapshot.data![index].initial_price.toString()) * quant;
                                        CartRepo().update(_database, CartModel(
                                            id: snapshot.data![index].id,
                                            name: snapshot.data![index].name,
                                            initial_price: snapshot.data![index].initial_price,
                                            products_price:update_price,
                                            image: snapshot.data![index].image,
                                            quantity: quant)).then((value){

                                          update_price = 0;
                                          quant = 0;
                                          cart.removeTotalPrice(double.parse(snapshot.data![index].initial_price.toString()));

                                        }).onError((error, stackTrace){
                                          print(error.toString());
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              spreadRadius: 1,
                                              blurRadius: 10)
                                        ],
                                      ),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Text("No Data");
          }
        });
  }
}

class MyListData extends StatefulWidget {
  int index;

  List<Map<String, dynamic>> orderList;
  MyListData({super.key, required this.index, required this.orderList});

  @override
  State<MyListData> createState() => _MyListStateData();
}

class _MyListStateData extends State<MyListData> {
  late int counter;
  late int product_price;
  late SharedPreferences prefs;

  Database? _database;

  Future<void> saveData(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt("count" + widget.index.toString()) ??
        widget.orderList![widget.index]['quantity'];
    product_price = prefs.getInt("pro_price" + widget.index.toString()) ??
        (int.tryParse(widget.orderList![widget.index]['price'])! * counter)!;
  }

  Future<void> deleteItem(String name) async {
    _database = await DatabaseHandler().openDB();
    _database!.rawDelete('DELETE FROM ORDERS WHERE name = ?', [name]);
    /* prefs = await SharedPreferences.getInstance();
  prefs.remove("Name");*/
    _database!.close();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("lowerclass");
    final cart = Provider.of<CartProvider>(context);
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(left: 15),
            child: Image.network(
              widget.orderList![widget.index]['image'],
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                widget.orderList![widget.index]['name'],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.navigation_color),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                product_price.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: MyTheme.navigation_color),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Column(
              children: [
                InkWell(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                  onTap: () {
                    cart.removeTotalPrice(
                        double.parse(widget.orderList![widget.index]['price']));
                    cart.removeCounter();
                    deleteItem(widget.orderList![widget.index]['name']);
                    widget.orderList!.removeAt(widget.index);

                    setState(() {
                      //          print('lastdata'+orderList![index]['name']);
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() async {
                          counter++;
                          product_price = counter *
                              int.parse(
                                  widget.orderList![widget.index]['price']);
                          cart.addTotalPrice(double.parse(widget
                              .orderList![widget.index]['price']
                              .toString()));
                          prefs = await SharedPreferences.getInstance();
                          saveData("count" + widget.index.toString(), counter);
                          saveData("pro_price" + widget.index.toString(),
                              product_price);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.add,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        counter.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.navigation_color),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        counter--;
                        product_price = counter *
                            int.parse(widget.orderList![widget.index]['price']);
                        cart.removeTotalPrice(double.parse(widget
                            .orderList![widget.index]['price']
                            .toString()));
                        saveData("count", counter);
                        saveData("pro_price", product_price);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.minus,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
