import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopit/utils/routes.dart';
import '../theme/theme.dart';
import '../widgets/categorieswidget.dart';
import '../widgets/homeappbar.dart';
import '../widgets/itemwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{

 

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                color:MyTheme.navigation_color ,
                child: Center(
                  child: Image.asset("assets/images/logo-no-background.png",
                    height: 100,
                    width: 100,),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, MyRoutes.profilepage);
                },
                child: ListTile(
                  leading: Icon(CupertinoIcons.profile_circled,
                  color: MyTheme.navigation_color,
                  size: 25,),
                  title:Text("Profile",
                    style: TextStyle(
                        color: MyTheme.navigation_color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, MyRoutes.cartpage);
                },
                child: ListTile(
                  leading: Icon(CupertinoIcons.cart_fill,
                    color: MyTheme.navigation_color,
                    size: 25,),
                  title:Text("Orders",
                    style: TextStyle(
                        color: MyTheme.navigation_color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(CupertinoIcons.settings,
                  color: MyTheme.navigation_color,
                  size: 25,),
                title:Text("Settings",
                  style: TextStyle(
                      color: MyTheme.navigation_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            HomeAppBar(),
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color:MyTheme.background_color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)
                )
              ),
              child: Column(

                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here..."
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          CupertinoIcons.camera_fill,
                          color: MyTheme.navigation_color,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 15))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    child:Text("Categories",
                    style: TextStyle(
                      color: MyTheme.navigation_color,
                      fontSize: 27,
                      fontWeight: FontWeight.bold
                    ),) ,
                  ),
                  CategoriesWidget(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical:20,horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Best Selling",
                          style: TextStyle(
                              color: MyTheme.navigation_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 27
                          ),
                        ),
                         SizedBox(height: 15,),
                        ItemWidget()
                      ],
                    )
                  ),

                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index){},
            backgroundColor: Colors.transparent,
          height: 70,
          color: MyTheme.navigation_color,
            items: [
              Icon(Icons.home,
              size: 30,
              color: Colors.white,),
              Icon(CupertinoIcons.cart_fill,
                size: 30,
                color: Colors.white,),
              Icon(Icons.list,
                size: 30,
                color: Colors.white,),

            ]),
      ),
    );
  }
}
