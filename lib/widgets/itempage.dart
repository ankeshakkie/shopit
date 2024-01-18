import 'package:flutter/material.dart';
import 'package:shopit/theme/theme.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      color: Colors.white,
      child: Row(
        children: [
            InkWell(
              onTap: ()
              {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: MyTheme.navigation_color,
                size: 30,
              ),
            ),
          Padding(
              padding: EdgeInsets.only(left: 20),
          child: Text("Product",
          style: TextStyle(
            fontSize: 23,
            color: MyTheme.navigation_color,
            fontWeight: FontWeight.bold
          ),),),
          Spacer(),
          Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
