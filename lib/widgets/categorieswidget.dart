import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopit/theme/theme.dart';

import '../Urls/all_url.dart';
import '../model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
{
  List<CategoryModel> allcatList = [];






  @override
  void initState() {
    getAllCategory();

    super.initState();
  }


  Future<List<CategoryModel>?>  getAllCategory() async {
    var response = await http.get(Uri.parse(AllUrls.category_url));
    var all_data = jsonDecode(response.body.toString());

    if(response.statusCode==200)
    {
      setState(() {

      });
      print(all_data);
      for(var current_data in all_data)
      {

        String image = current_data['image'];
        int id = current_data['id'];
        allcatList.add(CategoryModel(id: id, image: image));

      }
      //  print("GetListdata"+allcatList[3].image);
      //  allcatList.addAll(catList);
      print("Allsize"+allcatList.length.toString());
      allcatList.addAll(allcatList);
      return allcatList;
    }
    else{
      print("Not Successfule");
      return allcatList;
    }


  }


  @override
  Widget build(BuildContext context) {

    print("Checklist"+allcatList.length.toString());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if(allcatList.isNotEmpty)
            for(int i=0;i<allcatList.length;i++)
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Image.network(allcatList[i].image,
                        height: 30,
                        width: 30,),
                      SizedBox(width: 10,),
                      Text("Sandal",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.navigation_color
                        ),)
                    ],
                  )
              )
            else
              CircularProgressIndicator(),

        ],
      )
    );
  }
}
