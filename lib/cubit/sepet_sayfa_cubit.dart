import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_diyari/entity/sepet_yemekler.dart';
import 'package:yemek_diyari/repo/sepetyemeklerdao_repository.dart';


class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var srepo = SepetYemeklerDaoRepository();

  Future<void> sepettekiYemekleriGetir() async{
    var liste = await srepo.sepettekiYemekleriGetirRepo("ramazan");
    emit(liste);
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id,String kullanici_adi) async{
    var liste = await srepo.sepettenYemekSilRepo(sepet_yemek_id,"ramazan");
    await sepettekiYemekleriGetir();
  }

}