import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemek_diyari/entity/yemekler.dart';
import 'package:yemek_diyari/entity/yemekler_cevap.dart';

class YemeklerDaoRepository{

  List <Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }



  Future<List<Yemekler>> tumYemekleriAl() async {
   var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
   var cevap = await Dio().get(url);
   return parseYemeklerCevap(cevap.data.toString());
  }



}