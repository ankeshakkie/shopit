import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pswd_controller = TextEditingController();
  TextEditingController cnfpswd_controller = TextEditingController();

  void createAccount() async{

    String email = email_controller.text.toString().trim();
    String pswd = pswd_controller.text.toString().trim();
    String cnfpswd = cnfpswd_controller.text.toString().trim();

    if(!email.isEmpty || !pswd.isEmpty || !cnfpswd.isEmpty)
      {
        if(cnfpswd!=pswd)
          {
            SnackBar snackBar = SnackBar(content: Text("Password should be same."),
            backgroundColor: Colors.red,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        else{
            if(pswd.length<6 || cnfpswd.length<6)
              {
                SnackBar snackBar = SnackBar(content: Text("Password minimum length should be of 6 digit."),
                  backgroundColor: Colors.red,);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            else{
                     try{

                         UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                             email: email, password: pswd);

                         if(credential.user!=null)
                         {
                           AwesomeDialog(
                               context:context,
                               title: "User Created !",
                               dialogType: DialogType.success,
                               btnOkOnPress:(){
                                 Navigator.pop(context);
                               }
                           ).show();
                         }

                     }on FirebaseAuthException catch(ex)
    {
      print(ex.code.toString());
    }
            }

        }
      }
    else
      {
        SnackBar snackBar = SnackBar(content: Text("All fileds are required."),
        backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            child: Column(
              children: [
                 Image.asset("assets/images/logo-no-background.png",
                 height: 150,
                 width: 150,),
                SizedBox(height: 40,),

                TextFormField(
                  controller: email_controller,
                    decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyTheme.navigation_color,
                                width: 3
                            ),
                            borderRadius: BorderRadius.circular(7)

                        )
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: pswd_controller,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyTheme.navigation_color,
                                width: 3
                            ),
                            borderRadius: BorderRadius.circular(7)

                        )
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    obscureText: true,
                  controller: cnfpswd_controller,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        labelText: 'Confirm',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyTheme.navigation_color,
                                width: 3
                            ),
                            borderRadius: BorderRadius.circular(7)

                        )
                    )
                ),
                SizedBox(height: 30,),
                CupertinoButton(
                    color: MyTheme.navigation_color,
                    child: Text("Create Account",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ),),
                    onPressed: (){

                      createAccount();
                    }),

              ],
            ),
          ),
        ));
  }
}
