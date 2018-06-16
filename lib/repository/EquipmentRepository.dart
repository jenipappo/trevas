import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Equipment.dart';
import 'package:trevas/repository/Repository.dart';

class EquipmentRepository extends Repository<Equipment> {
  EquipmentRepository(String characterId) : super(Firestore.instance.collection("characters").document(characterId).collection("equipments"));
}