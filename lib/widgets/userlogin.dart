import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopit/theme/theme.dart';
import 'package:shopit/utils/routes.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pswd_controller = TextEditingController();

  void userLogin() async{
    String email = email_controller.text.toString().trim();
    String password = pswd_controller.text.toString().trim();

    if(!email.isEmpty || !password.isEmpty)
      {
        if(password.length>5)
          {
            try{
              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, password: password);
              if(userCredential!=null)
                {
                  Navigator.pushNamed(context, MyRoutes.homepage);
                }
            } on FirebaseAuthException catch(ex)
    {
      print(ex.code.toString());
    }

          }
        else{

        }
      }
    else{

    }



  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo-no-background.png',
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
                  SizedBox(height: 30,),
                  CupertinoButton(
                    color: MyTheme.navigation_color,
                      child: Text("Login",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),),
                      onPressed: (){
                             userLogin();
                      }),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){

                           Navigator.pushNamed(context, MyRoutes.signuppage);
                        },
                        child: Text("New User ?  Register",
                        style: TextStyle(
                          color: MyTheme.navigation_color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
