import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:yemek_diyari/entity/yemekler.dart';
import 'package:yemek_diyari/utils/color_utils.dart';

class YemekDetaySayfa extends StatefulWidget {
  Yemekler yemek;

  YemekDetaySayfa({required this.yemek});

  @override
  State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
  int toplam = 0;
  int yemek_fiyat = 0;
  int adet= 0;

  @override
  void initState() {
    var a = widget.yemek;
    yemek_fiyat = int.parse(a.yemek_fiyat);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var y = widget.yemek;
    return Scaffold(
      appBar: AppBar(backgroundColor: hexStringToColor("f29f05"),title: const Text("Yemek Detay"),),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Container(
              width: 350,
              height: 350,
             
              child:Column(
                children: [
                  SizedBox(height:200,width:200,child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${y.yemek_resim_adi}")),
                  Text("${y.yemek_adi}",style:const TextStyle(fontSize: 25,color: Color(0xff731702),fontWeight: FontWeight.bold),),
                  Text("$toplam ₺ tuttu",style:const TextStyle(fontSize: 30,color:Color(0xff731702)),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 50,height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                            setState(() {
                              adet = adet + 1;
                              if(adet>0){
                                toplam = toplam + yemek_fiyat;
                                print("$toplam");
                              }
                            });
                          },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff025930),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                                )
                              ),

                            child: const Text("+1",style: TextStyle(fontSize: 15),)),
                        ),
                        Text("$adet",style: TextStyle(fontSize: 25,color: Color(0xff731702),fontWeight: FontWeight.bold),),
                        SizedBox(height: 50,width: 50,
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              if(adet>0) {
                                toplam = toplam - yemek_fiyat;
                                adet = adet - 1;
                                print("$adet");
                              }
                            }
                            );
                          },
                              style: ElevatedButton.styleFrom(
                              primary: Color(0xff025930),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              )
                          ),  child: const Text("-1",style: TextStyle(fontSize: 15),)),
                        ),
                        SizedBox(height: 50,
                          child: ElevatedButton(onPressed: (){
                            if(adet>0){
                              context.read<YemekDetaySayfaCubit>().SepetYemekKayit(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi,toplam.toString(),adet.toString(), "ramazan");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sepete ($adet) adet ${widget.yemek.yemek_adi} eklendi.",
                                style: TextStyle(color: Colors.green,fontSize: 15),),
                              backgroundColor: Colors.white,duration: Duration(seconds: 2),));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Ürün 0 adet olamaz.",
                                  style: TextStyle(color: Colors.red,fontSize: 15)),
                              ),backgroundColor: Colors.white,duration: Duration(seconds: 2),));
                            }
                          },  style: ElevatedButton.styleFrom(
                              primary: Color(0xff025930),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),  child: const Text("Sepete ekle",style: TextStyle(fontSize: 20,),)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:  hexStringToColor("f29f05"),
                boxShadow: const[
                  BoxShadow(color:Colors.orange,spreadRadius: 5)
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
