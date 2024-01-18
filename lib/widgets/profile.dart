import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopit/theme/theme.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  File? profileImage;

  void sendDatatoServer() async {

     String name = name_controller.text.toString().trim();
     String email = email_controller.text.toString().trim();
     String phone = phone_controller.text.toString().trim();
     String address = address_controller.text.toString().trim();

     if(!name.isEmpty || !email.isEmpty || !phone.isEmpty || !address.isEmpty)
       {
         UploadTask uploadTask = FirebaseStorage.instance.ref().child('userpictures')
             .child(Uuid().v1()).putFile(profileImage!);



         Map<String,dynamic> mapDynamic = {
           'name': name,
           'email': email,
           'phone': phone,
           'address': address
         };

         await FirebaseFirestore.instance.collection('users').add(mapDynamic);

       }
     else
       {

       }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          backgroundColor: MyTheme.navigation_color,
          title: Text('Profile',
            style: TextStyle(
                color: Colors.white
            ),),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
            child:(FirebaseAuth.instance.currentUser!=null)? StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context,snapshots){

                if(snapshots.connectionState==ConnectionState.active)
                  {
                    if(snapshots.hasData && snapshots.data!=null)
                      {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshots.data!.size,
                              itemBuilder: (context,index){

                                 return Container(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       CupertinoButton(
                                         onPressed: () async{

                                           XFile? selectedImage = await ImagePicker().pickImage(
                                               source: ImageSource.gallery);  // for opening gallery

                                           if(selectedImage!=null)
                                           {
                                             File convertedImage = File(selectedImage!.path);
                                             setState(() {
                                               profileImage = convertedImage!;
                                             });
                                           }

                                         },
                                         child: Center(

                                           child: CircleAvatar(
                                             maxRadius: 50,
                                             backgroundColor: Colors.red,
                                             backgroundImage: (profileImage!=null)?FileImage(profileImage!):null,
                                           ),
                                         ),
                                       ),
                                       SizedBox(height: 50,),
                                       Row(

                                         children: [

                                           SizedBox(
                                             width: 100,
                                             child: Text("Name",
                                               style: TextStyle(
                                                   color: MyTheme.navigation_color,
                                                   fontSize: 17,
                                                   fontWeight: FontWeight.bold
                                               ),),
                                           ),

                                           Expanded(
                                             child:TextFormField(

                                               decoration: InputDecoration(
                                                 contentPadding: EdgeInsets.zero,
                                                 border: OutlineInputBorder(
                                                     borderSide: BorderSide(
                                                         color: MyTheme.navigation_color,
                                                         width: 2
                                                     ),
                                                     borderRadius: BorderRadius.circular(3)
                                                 ),

                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 20,),
                                       Row(

                                         children: [

                                           SizedBox(
                                             width: 100,
                                             child: Text("Email",
                                               style: TextStyle(
                                                   color: MyTheme.navigation_color,
                                                   fontSize: 17,
                                                   fontWeight: FontWeight.bold
                                               ),),
                                           ),
                                           Expanded(
                                             child: TextFormField(
                                               controller: email_controller,
                                               decoration: InputDecoration(
                                                 contentPadding: EdgeInsets.zero,
                                                 border: OutlineInputBorder(
                                                     borderSide: BorderSide(
                                                         color: MyTheme.navigation_color,
                                                         width: 2
                                                     ),
                                                     borderRadius: BorderRadius.circular(3)
                                                 ),

                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 20,),
                                       Row(

                                         children: [

                                           SizedBox(
                                             width: 100,
                                             child: Text("Phone",
                                               style: TextStyle(
                                                   color: MyTheme.navigation_color,
                                                   fontSize: 17,
                                                   fontWeight: FontWeight.bold
                                               ),),
                                           ),
                                           Expanded(
                                             child: TextFormField(
                                               controller: phone_controller,
                                               keyboardType: TextInputType.number,
                                               maxLength: 10,
                                               decoration: InputDecoration(
                                                 counterText: "",
                                                 contentPadding: EdgeInsets.zero,
                                                 border: OutlineInputBorder(

                                                     borderSide: BorderSide(
                                                         color: MyTheme.navigation_color,
                                                         width: 2
                                                     ),
                                                     borderRadius: BorderRadius.circular(3)
                                                 ),

                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 20,),
                                       Row(

                                         children: [

                                           SizedBox(
                                             width: 100,
                                             child: Text("Address",
                                               style: TextStyle(
                                                   color: MyTheme.navigation_color,
                                                   fontSize: 17,
                                                   fontWeight: FontWeight.bold
                                               ),),
                                           ),
                                           Expanded(
                                             child: TextFormField(
                                               controller: address_controller,
                                               decoration: InputDecoration(
                                                 contentPadding: EdgeInsets.zero,
                                                 border: OutlineInputBorder(
                                                     borderSide: BorderSide(
                                                         color: MyTheme.navigation_color,
                                                         width: 2
                                                     ),
                                                     borderRadius: BorderRadius.circular(3)
                                                 ),

                                               ),
                                             ),
                                           ),
                                         ],
                                       ),

                                       Spacer(),
                                       SizedBox(
                                         width: double.infinity,
                                         child: CupertinoButton(
                                             color: MyTheme.navigation_color,
                                             child: Text("Submit",
                                               style: TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 14
                                               ),),
                                             onPressed: (){

                                               sendDatatoServer();
                                             }),
                                       )
                                     ],
                                   ),
                                 ) ;

                              }),
                        );
                      }
                    else{

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CupertinoButton(
                            onPressed: () async{

                              XFile? selectedImage = await ImagePicker().pickImage(
                                  source: ImageSource.gallery);  // for opening gallery

                              if(selectedImage!=null)
                              {
                                File convertedImage = File(selectedImage!.path);
                                setState(() {
                                  profileImage = convertedImage!;
                                });
                              }

                            },
                            child: Center(

                              child: CircleAvatar(
                                maxRadius: 50,
                                backgroundColor: Colors.red,
                                backgroundImage: (profileImage!=null)?FileImage(profileImage!):null,
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),
                          Row(

                            children: [

                              SizedBox(
                                width: 100,
                                child: Text("Name",
                                  style: TextStyle(
                                      color: MyTheme.navigation_color,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),

                              Expanded(
                                child:TextFormField(
                                  controller: name_controller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyTheme.navigation_color,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(3)
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(

                            children: [

                              SizedBox(
                                width: 100,
                                child: Text("Email",
                                  style: TextStyle(
                                      color: MyTheme.navigation_color,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: email_controller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyTheme.navigation_color,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(3)
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(

                            children: [

                              SizedBox(
                                width: 100,
                                child: Text("Phone",
                                  style: TextStyle(
                                      color: MyTheme.navigation_color,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phone_controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: MyTheme.navigation_color,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(3)
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(

                            children: [

                              SizedBox(
                                width: 100,
                                child: Text("Address",
                                  style: TextStyle(
                                      color: MyTheme.navigation_color,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: address_controller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyTheme.navigation_color,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(3)
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),

                          Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton(
                                color: MyTheme.navigation_color,
                                child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14
                                  ),),
                                onPressed: (){

                                  sendDatatoServer();
                                }),
                          )
                        ],
                      );
                    }
                  }
                else
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          onPressed: () async{

                            XFile? selectedImage = await ImagePicker().pickImage(
                                source: ImageSource.gallery);  // for opening gallery

                            if(selectedImage!=null)
                            {
                              File convertedImage = File(selectedImage!.path);
                              setState(() {
                                profileImage = convertedImage!;
                              });
                            }

                          },
                          child: Center(

                            child: CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: Colors.red,
                              backgroundImage: (profileImage!=null)?FileImage(profileImage!):null,
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Row(

                          children: [

                            SizedBox(
                              width: 100,
                              child: Text("Name",
                                style: TextStyle(
                                    color: MyTheme.navigation_color,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),

                            Expanded(
                              child:TextFormField(
                                controller: name_controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.navigation_color,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(

                          children: [

                            SizedBox(
                              width: 100,
                              child: Text("Email",
                                style: TextStyle(
                                    color: MyTheme.navigation_color,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: email_controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.navigation_color,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(

                          children: [

                            SizedBox(
                              width: 100,
                              child: Text("Phone",
                                style: TextStyle(
                                    color: MyTheme.navigation_color,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phone_controller,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(

                                      borderSide: BorderSide(
                                          color: MyTheme.navigation_color,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(

                          children: [

                            SizedBox(
                              width: 100,
                              child: Text("Address",
                                style: TextStyle(
                                    color: MyTheme.navigation_color,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: address_controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.navigation_color,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),

                        Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                              color: MyTheme.navigation_color,
                              child: Text("Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                              onPressed: (){

                                sendDatatoServer();
                              }),
                        )
                      ],
                    );
                  }
              },

            ):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoButton(
                  onPressed: () async{

                    XFile? selectedImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery);  // for opening gallery

                    if(selectedImage!=null)
                    {
                      File convertedImage = File(selectedImage!.path);
                      setState(() {
                        profileImage = convertedImage!;
                      });
                    }

                  },
                  child: Center(

                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.red,
                      backgroundImage: (profileImage!=null)?FileImage(profileImage!):null,
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(

                  children: [

                    SizedBox(
                      width: 100,
                      child: Text("Name",
                        style: TextStyle(
                            color: MyTheme.navigation_color,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                    ),

                    Expanded(
                      child:TextFormField(
                        controller: name_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyTheme.navigation_color,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(3)
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(

                  children: [

                    SizedBox(
                      width: 100,
                      child: Text("Email",
                        style: TextStyle(
                            color: MyTheme.navigation_color,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: email_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyTheme.navigation_color,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(3)
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(

                  children: [

                    SizedBox(
                      width: 100,
                      child: Text("Phone",
                        style: TextStyle(
                            color: MyTheme.navigation_color,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phone_controller,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(

                              borderSide: BorderSide(
                                  color: MyTheme.navigation_color,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(3)
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(

                  children: [

                    SizedBox(
                      width: 100,
                      child: Text("Address",
                        style: TextStyle(
                            color: MyTheme.navigation_color,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: address_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyTheme.navigation_color,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(3)
                          ),

                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                      color: MyTheme.navigation_color,
                      child: Text("Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ),),
                      onPressed: (){

                        sendDatatoServer();
                      }),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
