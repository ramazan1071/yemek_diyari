import 'package:flutter/material.dart';
import 'package:yemek_diyari/views/anasayfa.dart';
import 'package:yemek_diyari/views/signin_screen.dart';

class AcilisSayfa extends StatefulWidget {
  const AcilisSayfa({Key? key}) : super(key: key);

  @override
  State<AcilisSayfa> createState() => _AcilisSayfaState();
}

class _AcilisSayfaState extends State<AcilisSayfa> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
        (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ic.png"),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}
