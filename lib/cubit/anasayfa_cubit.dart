import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/entity/yemekler.dart';
import 'package:yemek_diyari/repo/yemeklerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{

  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async{
    var liste = await yrepo.tumYemekleriAl();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async{
    var liste = await yrepo.tumYemekleriAl();
    List <Yemekler> yemekListesi = [];
    liste.forEach((yemek) {
      if(yemek.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase())){
        yemekListesi.add(yemek);
      }
      emit(yemekListesi);
    });
  }



}