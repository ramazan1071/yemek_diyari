import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/cubit/anasayfa_cubit.dart';
import 'package:yemek_diyari/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_diyari/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:yemek_diyari/views/signup_screen.dart';
import 'package:yemek_diyari/views/acilis_sayfa.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => YemekDetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const AcilisSayfa(),
      ),
    );
  }
}
