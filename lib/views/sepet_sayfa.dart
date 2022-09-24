import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_diyari/entity/sepet_yemekler.dart';
import 'package:yemek_diyari/utils/color_utils.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  var toplam_Tutar ;
  @override
  void initState() {
    super.initState();
    toplam_Tutar = 0;
    context.read<SepetSayfaCubit>().sepettekiYemekleriGetir();

  }
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(backgroundColor: hexStringToColor("f29f05"),title: const Text("Sepet"),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(height:45,width:45,child: Image.asset("assets/logo.png")),
        ),],),
      body: Center(
        child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 500,width: 500,
              child: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
                  builder: (context,sepetYemeklerListesi){
                    toplam_Tutar = 0;
                    for (var i = 0; i < sepetYemeklerListesi.length; i++) {
                      toplam_Tutar += int.parse(sepetYemeklerListesi[i].yemek_fiyat) * int.parse(sepetYemeklerListesi[i].yemek_siparis_adet);
                    }
                    if(sepetYemeklerListesi.isNotEmpty){
                      return SizedBox(height: 500,width: 500,
                        child: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
                            builder: (context,sepetYemeklerListesi){
                              if(sepetYemeklerListesi.isNotEmpty){
                                return ListView.builder(
                                  itemCount: sepetYemeklerListesi.length,
                                  itemBuilder: (context,indeks){
                                    var yemek = sepetYemeklerListesi[indeks];

                                    return
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.5
                                            ),
                                            borderRadius: BorderRadius.circular(15.0)
                                        ),
                                        child: Row(
                                          children: [
                                               Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Container(
                                                  height:90,
                                                  width: 90,

                                                  child: SizedBox(width: 20,height: 20,
                                                      child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")
                                                  ),
                                              ),
                                               ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Row(
                                                children: [
                                                  Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("(${yemek.yemek_siparis_adet} adet)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("${int.parse(yemek.yemek_fiyat) * int.parse(yemek.yemek_siparis_adet)} ₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(onTap:(){
                                              context.read<SepetSayfaCubit>().sepettenYemekSil(yemek.sepet_yemek_id, "ramazan");

                                            },child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: const Icon(Icons.clear,color: Colors.red,),
                                            ))
                                          ],
                                        ),
                                      );
                                  },
                                );
                              }
                              else{
                                return const Text("Sepet Boş");
                              }
                            }
                        ),
                      );
                    }
                    else{
                      return const Text("Sepet Boş");
                    }
                  }
              ),
            ),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Toplam Tutar : ${toplam_Tutar}₺",style: TextStyle(fontSize: 20),),
                        SizedBox(height: 50,
                          child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                              primary: Color(0xff025930),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              )), child: const Text("Ödeme Yap")),
                        ),
                      ],
                    )
          ],
        ),
      ),
    );
  }
}

/*
  SizedBox(height: 500,width: 500,
              child: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
                  builder: (context,sepetYemeklerListesi){
                    if(sepetYemeklerListesi.isNotEmpty){
                      return ListView.builder(
                        itemCount: sepetYemeklerListesi.length,
                        itemBuilder: (context,indeks){
                          var yemek = sepetYemeklerListesi[indeks];
                          return
                             Card(
                              child: Row(
                                children: [
                                  SizedBox(width: 150,height: 150,
                                      child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")
                                  ),
                                  Row(
                                    children: [
                                      Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                      Text("${yemek.sepet_yemek_id}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_right)
                                ],
                              ),
                          );
                        },
                      );
                    }
                    else{
                      return const Text("Sepet Boş");
                    }
                  }
              ),
            ),
 */