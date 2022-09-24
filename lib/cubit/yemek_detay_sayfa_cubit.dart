import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/repo/sepetyemeklerdao_repository.dart';
import 'package:yemek_diyari/repo/yemeklerdao_repository.dart';

class YemekDetaySayfaCubit extends Cubit<void>{
  YemekDetaySayfaCubit():super(0);

  var srepo= SepetYemeklerDaoRepository();

  Future<void> SepetYemekKayit(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async{
    await srepo.SepetYemekKayitRepo(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }


}