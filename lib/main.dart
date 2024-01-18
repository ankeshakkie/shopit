
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopit/firebase_options.dart';
import 'package:shopit/pages/homepage.dart';
import 'package:shopit/provider/cart_provider.dart';
import 'package:shopit/utils/routes.dart';
import 'package:shopit/widgets/cartpage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shopit/widgets/profile.dart';
import 'package:shopit/widgets/signup.dart';
import 'package:shopit/widgets/userlogin.dart';





void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> CartProvider(),
        child: Builder(builder: (BuildContext context){
          return MaterialApp(
            debugShowCheckedModeBanner:false ,
            title: 'Flutter Demo',
            theme: ThemeData(

              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:AnimatedSplashScreen(
                splash: Image.asset("assets/images/logo-no-background.png",
                  height: 150,
                  width: 150,),
                splashTransition: SplashTransition.sizeTransition,

                nextScreen:(FirebaseAuth.instance.currentUser!=null)?HomePage():UserLogin()),
            routes:
            {
              MyRoutes.cartpage:(context)=> CartPage(),
              MyRoutes.profilepage:(context)=> ProfileScreen(),
              MyRoutes.userloginpage:(context)=> UserLogin(),
              MyRoutes.signuppage:(context)=> SignupScreen(),
              MyRoutes.homepage:(context)=> HomePage()

            },
          );
    },),);
  }
}


