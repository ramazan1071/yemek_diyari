import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/cubit/anasayfa_cubit.dart';
import 'package:yemek_diyari/utils/color_utils.dart';
import 'package:yemek_diyari/views/sepet_sayfa.dart';
import 'package:yemek_diyari/views/yemek_detay_sayfa.dart';
import 'package:yemek_diyari/entity/yemekler.dart';
import 'package:yemek_diyari/utils/color_utils.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("f29f05"),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(height:45,width:45,child: Image.asset("assets/logo.png")),
          ),
          title: const Text("Lezzet Diyarı",textAlign: TextAlign.center,),
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
          }, icon: Icon(Icons.shopping_basket))],
      ),
      body: Center(
        child:
        SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child:TextField(autofocus:false,textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                    hintText: " Yemek Ara",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black54, ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                    onChanged: (aramaSonucu){
                      context.read<AnasayfaCubit>().ara(aramaSonucu);
                    },),
                ),
              ),
              SizedBox(height: 500,
                child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                    builder: (context,yemeklerListesi){
                      if(yemeklerListesi.isNotEmpty){
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2
                          ),
                          itemCount: yemeklerListesi.length,
                          itemBuilder: (context,indeks){
                            var yemek = yemeklerListesi[indeks];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => YemekDetaySayfa(yemek: yemek)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.5
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: 80,height: 80,
                                        child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")
                                    ),
                                        Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 20),),
                                    Text("${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xfff29f05)),)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else{
                        return const Center();
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





