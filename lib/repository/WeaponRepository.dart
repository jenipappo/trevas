import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Weapon.dart';
import 'package:trevas/repository/Repository.dart';

class WeaponRepository extends Repository<Weapon> {
  WeaponRepository(String characterId) : super(Firestore.instance.collection("characters").document(characterId).collection("weapons"));
}