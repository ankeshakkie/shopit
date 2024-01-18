import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopit/theme/theme.dart';
import 'package:shopit/widgets/cartappbar.dart';
import 'package:shopit/widgets/cartitem_samples.dart';
import 'package:sqflite/sqflite.dart';

import '../database/DatabaseHandler.dart';
import '../repository/CartRepo.dart';
import 'bottomnavigationbar.dart';



class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static GlobalKey<_CartPageState> createKey() => GlobalKey<_CartPageState>();

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<Map<String,dynamic>>? orderList = [];
  Database? _database;
  int final_price = 0;




  @override
  void initState() {

    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CartApp(),
          Container(
            height: 700,
            decoration: BoxDecoration(
              color: MyTheme.background_color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              )
            ),
            child: CartItemSamples(),
          )
        ],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
