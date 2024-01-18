import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopit/provider/cart_provider.dart';
import 'package:shopit/theme/theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopit/utils/routes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Scaffold.of(context).openDrawer();  // code to oopen drawer
            },
            child: Padding(
                padding: EdgeInsets.all(25),
            child: Icon(Icons.sort,
            size: 30,
            color: MyTheme.navigation_color,),),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
          child: Text("Shopit",
          style: TextStyle(
            fontSize: 23,
            color: MyTheme.navigation_color,
            fontWeight: FontWeight.bold
          ),),),
          Spacer(),
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context,value,child){
               print("counterdata"+value.getCounter().toString());
                return Text(value.getCounter().toString(),

                  style: TextStyle(
                      color: Colors.white
                  ),);

  }

            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red
            ),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.cartpage);
              },
              child: Icon(
                Icons.shopping_bag_rounded,
                color: MyTheme.navigation_color,
                size: 30,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15))
        ],
      ),
    );
  }
}
